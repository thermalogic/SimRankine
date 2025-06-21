import { BoilerReheat } from './devices/BoilerReheat.js';
import { TurbineEx1 } from './devices/TurbineEx1.js';
import { TurbineSimple } from './devices/TurbineSimple.js';
import { Condenser } from './devices/Condenser.js';
import { Pump } from './devices/Pump.js';
import { Boiler } from './devices/Boiler.js';
import { Heater } from './devices/Heater.js';

class RankineDesignApp {
  constructor() {
    this.devices = [];
    this.connections = [];
    this.selectedDevice = null;
    this.selectedConnection = null;
    this.isDragging = false;
    this.isConnectionMode = false;
    this.connectionStartPort = null;
    this.nextId = 1;
    this.nextConnectionId = 1;
    
    this.initUI();
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
    e.preventDefault();  // 防止默认行为干扰
    e.stopPropagation(); // 阻止事件冒泡
    
    console.log('Port clicked:', {  // 调试日志
        device: device.type, 
        port: port.type,
        mode: this.isConnectionMode ? 'Connection' : 'Selection'
    });

    if (this.isConnectionMode) {
        if (!this.connectionStartPort) {
            // 第一阶段：选择起始端口
            if (this.isOutputPort(port.type)) {
                this.connectionStartPort = { 
                    device: device, 
                    port: port 
                };
                port.element.classList.add('port-highlight');
                console.log('First port selected:', port.type);
            }
        } else {
            // 第二阶段：选择目标端口
            if (this.isValidConnection(this.connectionStartPort, device, port)) {
                this.createConnection(
                    this.connectionStartPort.device,
                    this.connectionStartPort.port,
                    device,
                    port
                );
            }
            this.resetConnectionMode();
        }
    } else {
        // 非连接模式下的处理
        this.selectDevice(device);
    }
}

isValidConnection(start, endDevice, endPort) {
    // 不能连接到自身
    if (start.device === endDevice) {
        console.log('Cannot connect to same device');
        return false;
    }
    
    // 必须是从输出端口到输入端口
    const validCombinations = [
        ['outlet', 'inlet'],
        ['exlet', 'inlet'],
        ['outletRH', 'inletRH'],
        ['outletFW', 'inletFW']
    ];
    
    const isValid = validCombinations.some(
        ([outType, inType]) => 
            start.port.type === outType && 
            endPort.type === inType
    );
    
    if (!isValid) {
        console.log('Invalid port combination:', 
                   start.port.type, '->', endPort.type);
    }
    
    return isValid;
}

// 修改toggleConnectionMode方法
toggleConnectionMode() {
    this.isConnectionMode = !this.isConnectionMode;
    const btn = document.getElementById('connectionModeBtn');
    btn.classList.toggle('active', this.isConnectionMode);
    
    // 视觉反馈
    if (this.isConnectionMode) {
        btn.textContent = 'Connection Mode (ON)';
        console.log('Connection mode activated');
    } else {
        btn.textContent = 'Connection Mode (OFF)';
        this.resetConnectionMode();
    }
}

  isOutputPort(portType) {
    return ['outlet', 'exlet', 'outletFW', 'outletRH'].includes(portType);
  }

  isInputPort(portType) {
    return ['inlet', 'inletSM', 'inletRH', 'inletFW'].includes(portType);
  }

createConnection(fromDevice, fromPort, toDevice, toPort) {
    // 检查是否已存在相同连接
    const existing = this.connections.find(conn => 
        (conn.fromDevice === fromDevice && 
         conn.fromPort === fromPort &&
         conn.toDevice === toDevice &&
         conn.toPort === toPort) ||
        (conn.fromDevice === toDevice && 
         conn.fromPort === toPort &&
         conn.toDevice === fromDevice &&
         conn.toPort === fromPort)
    );
    
    if (existing) {
        console.log('Connection already exists');
        return;
    }

    console.log('Creating connection:', 
               `${fromDevice.type}:${fromPort.type} -> ${toDevice.type}:${toPort.type}`);

    const connectionElement = document.createElement('div');
    connectionElement.className = 'connection';
    
    const arrowElement = document.createElement('div');
    arrowElement.className = 'connection-arrow';
    
    const connection = {
      id: this.nextConnectionId++,
      element: connectionElement,
      arrowElement: arrowElement,
      fromDevice: fromDevice,
      fromPort: fromPort,
      toDevice: toDevice,
      toPort: toPort
    };
    
    connectionElement.addEventListener('mousedown', (e) => {
      this.selectConnection(connection);
      e.stopPropagation();
    });
    
    arrowElement.addEventListener('mousedown', (e) => {
      this.selectConnection(connection);
      e.stopPropagation();
    });
    
    this.updateConnectionPosition(connection);
    this.connections.push(connection);
    this.canvas.appendChild(connectionElement);
    this.canvas.appendChild(arrowElement);
  }

  updateConnectionPosition(connection) {
    const fromRect = connection.fromPort.element.getBoundingClientRect();
    const toRect = connection.toPort.element.getBoundingClientRect();
    
    const canvasRect = this.canvas.getBoundingClientRect();
    
    const fromX = fromRect.left + fromRect.width/2 - canvasRect.left;
    const fromY = fromRect.top + fromRect.height/2 - canvasRect.top;
    const toX = toRect.left + toRect.width/2 - canvasRect.left;
    const toY = toRect.top + toRect.height/2 - canvasRect.top;
    
    const length = Math.sqrt(Math.pow(toX - fromX, 2) + Math.pow(toY - fromY, 2));
    const angle = Math.atan2(toY - fromY, toX - fromX) * 180 / Math.PI;
    
    connection.element.style.width = length + 'px';
    connection.element.style.left = fromX + 'px';
    connection.element.style.top = fromY + 'px';
    connection.element.style.transform = `rotate(${angle}deg)`;
    
    // 箭头位置
    const arrowX = toX - 6 * Math.cos(angle * Math.PI / 180);
    const arrowY = toY - 6 * Math.sin(angle * Math.PI / 180);
    
    connection.arrowElement.style.left = arrowX + 'px';
    connection.arrowElement.style.top = arrowY + 'px';
    connection.arrowElement.style.transform = `rotate(${angle}deg)`;
  }

  toggleConnectionMode() {
    this.isConnectionMode = !this.isConnectionMode;
    document.getElementById('connectionModeBtn').classList.toggle('active', this.isConnectionMode);
    
    if (!this.isConnectionMode && this.connectionStartPort) {
      this.connectionStartPort.port.element.classList.remove('port-highlight');
      this.connectionStartPort = null;
    }
  }

  resetConnectionMode() {
    if (this.connectionStartPort) {
      this.connectionStartPort.port.element.classList.remove('port-highlight');
      this.connectionStartPort = null;
    }
    this.isConnectionMode = false;
    document.getElementById('connectionModeBtn').classList.remove('active');
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
      this.updateConnectionsForDevice(this.selectedDevice);
      
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

  updateConnectionsForDevice(device) {
    this.connections.forEach(conn => {
      if (conn.fromDevice === device || conn.toDevice === device) {
        this.updateConnectionPosition(conn);
      }
    });
  }

  selectDevice(device) {
    // 清除之前的选择
    if (this.selectedDevice) {
      this.selectedDevice.element.classList.remove('selected');
    }
    if (this.selectedConnection) {
      this.selectedConnection.element.style.backgroundColor = '#0083a9';
      this.selectedConnection.arrowElement.style.borderLeftColor = '#0083a9';
      this.selectedConnection = null;
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

  selectConnection(connection) {
    // 清除之前的选择
    if (this.selectedDevice) {
      this.selectedDevice.element.classList.remove('selected');
      this.selectedDevice = null;
    }
    if (this.selectedConnection) {
      this.selectedConnection.element.style.backgroundColor = '#0083a9';
      this.selectedConnection.arrowElement.style.borderLeftColor = '#0083a9';
    }
    
    this.selectedConnection = connection;
    
    if (connection) {
      connection.element.style.backgroundColor = 'red';
      connection.arrowElement.style.borderLeftColor = 'red';
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
    this.updateConnectionsForDevice(device);
  }

  deleteSelected() {
    if (this.selectedDevice) {
      // 删除相关连接
      const connectionsToRemove = this.connections.filter(conn => 
        conn.fromDevice === this.selectedDevice || 
        conn.toDevice === this.selectedDevice
      );
      
      connectionsToRemove.forEach(conn => {
        this.canvas.removeChild(conn.element);
        this.canvas.removeChild(conn.arrowElement);
        this.connections = this.connections.filter(c => c !== conn);
      });
      
      // 删除设备
      this.canvas.removeChild(this.selectedDevice.element);
      this.devices = this.devices.filter(d => d !== this.selectedDevice);
      this.selectedDevice = null;
      this.propertyForm.classList.add('hidden');
      this.noSelectionMessage.classList.remove('hidden');
    } 
    else if (this.selectedConnection) {
      this.canvas.removeChild(this.selectedConnection.element);
      this.canvas.removeChild(this.selectedConnection.arrowElement);
      this.connections = this.connections.filter(c => c !== this.selectedConnection);
      this.selectedConnection = null;
    }
  }

  clearSelection() {
    this.selectDevice(null);
    this.selectConnection(null);
    this.resetConnectionMode();
  }
}

// 启动应用
document.addEventListener('DOMContentLoaded', () => {
  new RankineDesignApp();
});