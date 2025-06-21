import { BoilerReheat } from './devices/BoilerReheat.js';
import { TurbineEx1 } from './devices/TurbineEx1.js';
import { TurbineSimple } from './devices/TurbineSimple.js';
import { Condenser } from './devices/Condenser.js';
import { Pump } from './devices/Pump.js';
import { Boiler } from './devices/Boiler.js';
import { Heater } from './devices/Heater.js';
import { ConnectionManager } from './managers/ConnectionManager.js';
import { FileManager } from './managers/FileManager.js';

class RankineDesignApp {
  constructor() {
    this.fileManager = new FileManager(this);

    this.devices = [];
    this.selectedDevice = null;
    this.isDragging = false;
    this.isConnectionMode = false;
    this.connectionStartPort = null;
    this.nextId = 1;

    this.initUI();
    this.connectionManager = new ConnectionManager(this.canvas);
    this.setupEventListeners();
  }

  initUI() {
    this.canvas = document.getElementById('designCanvas');
    this.propertyForm = document.getElementById('propertyForm');
    this.noSelectionMessage = document.getElementById('noSelectionMessage');

    // 初始化设备类型下拉菜单
    this.deviceTypeSelect = document.getElementById('deviceType');
    this.deviceTypeSelect.innerHTML = `
      <option value="TurbineEx1_ph">Turbine (Extraction)</option>
      <option value="Turbine_ph">Turbine (Simple)</option>
      <option value="Condenser_ph">Condenser</option>
      <option value="Pump_ph">Pump</option>
      <option value="Boiler_ph">Boiler</option>
      <option value="BoilerReheat_ph">Reheat Boiler</option>
      <option value="OpenedheaterDw0_ph">Feedwater Heater</option>
    `;
  }

  setupEventListeners() {
    // 设备添加按钮
    document.getElementById('addReheatBoiler').addEventListener('click', () => {
      this.addDevice(new BoilerReheat(this.nextId++, 100, 100));
    });
    document.getElementById('addTurbine').addEventListener('click', () => {
      this.addDevice(new TurbineEx1(this.nextId++, 200, 100));
    });
    document.getElementById('addSimpleTurbine').addEventListener('click', () => {
      this.addDevice(new TurbineSimple(this.nextId++, 300, 100));
    });
    document.getElementById('addCondenser').addEventListener('click', () => {
      this.addDevice(new Condenser(this.nextId++, 400, 100));
    });
    document.getElementById('addPump').addEventListener('click', () => {
      this.addDevice(new Pump(this.nextId++, 500, 100));
    });
    document.getElementById('addBoiler').addEventListener('click', () => {
      this.addDevice(new Boiler(this.nextId++, 600, 100));
    });
    document.getElementById('addHeater').addEventListener('click', () => {
      this.addDevice(new Heater(this.nextId++, 700, 100));
    });

    // 连接模式
    document.getElementById('connectionModeBtn').addEventListener('click', () => {
      this.toggleConnectionMode();
    });

    // 删除选中项
    document.getElementById('deleteSelected').addEventListener('click', () => {
      this.deleteSelected();
    });

    // 更新属性
    document.getElementById('updateProperties').addEventListener('click', () => {
      this.updateDeviceProperties();
    });

    // 画布点击
    this.canvas.addEventListener('mousedown', (e) => {
      if (e.target === this.canvas) {
        this.clearSelection();
      }
    });
    // 添加保存/加载事件
    document.getElementById('saveDesign').addEventListener('click', () => {
      this.fileManager.saveDesign();
    });

    document.getElementById('loadDesign').addEventListener('click', () => {
      document.getElementById('fileInput').click();
    });

    document.getElementById('fileInput').addEventListener('change', async (e) => {
      const file = e.target.files[0];
      if (!file) return;

      try {
        await this.fileManager.loadDesign(file);
        this.clearSelection();
        console.log('Design loaded successfully');
      } catch (error) {
        console.error('Error loading design:', error);
        alert('Error loading design: ' + error.message);
      }

      // 重置文件输入，允许重复加载同一文件
      e.target.value = '';
    });
  }

  addDevice(device) {
    device.onDeviceClick = (e) => this.handleDeviceClick(e, device);
    device.onPortClick = (e, port) => this.handlePortClick(e, device, port);

    this.devices.push(device);
    this.canvas.appendChild(device.element);
    this.selectDevice(device);
  }

  handleDeviceClick(e, device) {
    if (this.isConnectionMode) return;

    this.startDrag(e, device);
    this.selectDevice(device);
    e.stopPropagation();
  }

  handlePortClick(e, device, port) {
    e.preventDefault();
    e.stopPropagation();

    console.log('Port clicked:', {
      device: device.type,
      port: port.type,
      mode: this.isConnectionMode ? 'CONNECTION' : 'SELECTION'
    });

    if (this.isConnectionMode) {
      if (!this.connectionStartPort) {
        // 第一阶段：选择起始端口
        if (this.isOutputPort(port.type)) {
          this.connectionStartPort = {
            device: device,
            port: port,
            element: port.element
          };
          port.element.style.boxShadow = '0 0 0 3px yellow';
          console.log('First port selected:', port.type);
        }
      } else {
        // 第二阶段：完成连接
        if (this.isValidConnection(this.connectionStartPort, device, port)) {
          const connection = this.connectionManager.createConnection(
            this.connectionStartPort.device,
            this.connectionStartPort.port,
            device,
            port
          );

          if (!connection) {
            console.error('Failed to create connection');
          }
        } else {
          console.warn('Invalid connection attempt');
        }

        // 重置起始端口样式
        if (this.connectionStartPort.element) {
          this.connectionStartPort.element.style.boxShadow = '';
        }
        this.connectionStartPort = null;
      }
    } else {
      // 非连接模式下的选择逻辑
      this.selectDevice(device);
    }
  }


  isValidConnection(start, endDevice, endPort) {
    // 不能连接到自身设备
    if (start.device === endDevice) {
      console.warn('Cannot connect to same device');
      return false;
    }

    // 验证端口组合
    const validCombinations = {
      'outlet': ['inlet', 'inletSM'],
      'exlet': ['inlet', 'inletFW'],
      'outletRH': ['inletRH'],
      'outletFW': ['inletFW']
    };

    const isValid = validCombinations[start.port.type]?.includes(endPort.type);

    console.log('Connection validation:', {
      from: start.port.type,
      to: endPort.type,
      valid: isValid
    });

    return isValid;
  }

  toggleConnectionMode() {
    this.isConnectionMode = !this.isConnectionMode;
    document.getElementById('connectionModeBtn').classList.toggle('active', this.isConnectionMode);

    if (!this.isConnectionMode) {
      this.resetConnectionMode();
    }
  }

  resetConnectionMode() {
    if (this.connectionStartPort) {
      this.connectionStartPort.port.element.classList.remove('port-highlight');
      this.connectionStartPort = null;
    }
  }

  isOutputPort(portType) {
    return ['outlet', 'exlet', 'outletFW', 'outletRH'].includes(portType);
  }

  isInputPort(portType) {
    return ['inlet', 'inletSM', 'inletRH', 'inletFW'].includes(portType);
  }

  startDrag(e, device) {
    this.isDragging = true;
    this.selectedDevice = device;
    this.offsetX = e.clientX - device.x;
    this.offsetY = e.clientY - device.y;

    document.addEventListener('mousemove', this.drag.bind(this));
    document.addEventListener('mouseup', this.stopDrag.bind(this));
  }

  drag(e) {
    if (this.isDragging && this.selectedDevice) {
      const x = e.clientX - this.offsetX;
      const y = e.clientY - this.offsetY;
      this.selectedDevice.move(x, y);

      // 更新连接线
      this.connectionManager.updateConnectionsForDevice(this.selectedDevice);

      // 更新属性面板中的位置
      document.getElementById('xPosition').value = x;
      document.getElementById('yPosition').value = y;
    }
  }

  stopDrag() {
    this.isDragging = false;
    document.removeEventListener('mousemove', this.drag);
    document.removeEventListener('mouseup', this.stopDrag);
  }

  selectDevice(device) {
    // 清除之前的选择
    if (this.selectedDevice) {
      this.selectedDevice.element.classList.remove('selected');
    }
    if (this.connectionManager.selectedConnection) {
      this.connectionManager.selectConnection(null);
    }

    this.selectedDevice = device;

    if (device) {
      device.element.classList.add('selected');
      this.showDeviceProperties(device);
      this.propertyForm.classList.remove('hidden');
      this.noSelectionMessage.classList.add('hidden');
    } else {
      this.propertyForm.classList.add('hidden');
      this.noSelectionMessage.classList.remove('hidden');
    }
  }

  showDeviceProperties(device) {
    this.deviceTypeSelect.value = device.type;

    // 隐藏所有属性区域
    document.querySelectorAll('.property-section').forEach(el => {
      el.classList.add('hidden');
    });

    // 显示对应设备的属性
    const sectionId = `${device.type.split('_')[0].toLowerCase()}Properties`;
    const section = document.getElementById(sectionId);
    if (section) section.classList.remove('hidden');

    // 填充属性值
    for (const [key, value] of Object.entries(device.parameters)) {
      const input = document.getElementById(`${sectionId}_${key}`);
      if (input) input.value = value;
    }

    // 更新位置
    document.getElementById('xPosition').value = device.x;
    document.getElementById('yPosition').value = device.y;
  }

  updateDeviceProperties() {
    if (!this.selectedDevice) return;

    const device = this.selectedDevice;
    const sectionId = `${device.type.split('_')[0].toLowerCase()}Properties`;

    // 更新参数
    for (const key in device.parameters) {
      const input = document.getElementById(`${sectionId}_${key}`);
      if (input) {
        device.parameters[key] = parseFloat(input.value);
      }
    }

    // 更新位置
    const x = parseInt(document.getElementById('xPosition').value);
    const y = parseInt(document.getElementById('yPosition').value);
    device.move(x, y);
    this.connectionManager.updateConnectionsForDevice(device);
  }

  deleteSelected() {
    if (this.selectedDevice) {
      this.connectionManager.deleteConnectionsForDevice(this.selectedDevice);
      this.canvas.removeChild(this.selectedDevice.element);
      this.devices = this.devices.filter(d => d !== this.selectedDevice);
      this.selectedDevice = null;
      this.propertyForm.classList.add('hidden');
      this.noSelectionMessage.classList.remove('hidden');
    }
    else if (this.connectionManager.selectedConnection) {
      this.connectionManager.deleteConnection(this.connectionManager.selectedConnection);
      this.connectionManager.selectConnection(null);
    }
  }

  clearSelection() {
    this.selectDevice(null);
    this.connectionManager.selectConnection(null);
    this.resetConnectionMode();
  }
}

// 启动应用
document.addEventListener('DOMContentLoaded', () => {
  new RankineDesignApp();
});