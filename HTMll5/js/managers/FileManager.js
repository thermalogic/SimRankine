
import { DeviceRegistry } from './DeviceRegistry.js';

export class FileManager {
    constructor(app) {
        this.app = app;
        this.initializeDeviceRegistry(); // 初始化设备注册

    }

async initializeDeviceRegistry() {
        try {
            // 从指定路径加载设备映射配置
            await DeviceRegistry.initFromConfig('./config/device-mappings.json');
            console.log('设备注册表初始化完成');
        } catch (error) {
            console.error('设备注册表初始化失败:', error);
            throw error; // 可改为更友好的错误处理
        }
    }

    saveDesign() {
        const design = {
            version: "1.0",
            devices: this.app.devices.map(device => ({
                id: device.id,
                type: device.type,
                x: device.x,
                y: device.y,
                parameters: device.parameters
            })),
            connections: this.app.connectionManager.connections.map(conn => ({
                fromDeviceId: conn.fromDevice.id,
                fromPortType: conn.fromPort.type,
                toDeviceId: conn.toDevice.id,
                toPortType: conn.toPort.type
            })),
            nextId: this.app.nextId,
            nextConnectionId: this.app.connectionManager.nextConnectionId
        };

        const dataStr = JSON.stringify(design, null, 2);
        const dataUri = 'data:application/json;charset=utf-8,' + encodeURIComponent(dataStr);

        const exportName = 'rankine_design_' + new Date().toISOString().slice(0, 10) + '.json';

        const linkElement = document.createElement('a');
        linkElement.setAttribute('href', dataUri);
        linkElement.setAttribute('download', exportName);
        linkElement.click();
    }

    async loadDesign(file) {
        return new Promise((resolve, reject) => {
            const reader = new FileReader();

            reader.onload = (e) => {
                try {
                    const design = JSON.parse(e.target.result);
                    this.clearCurrentDesign();
                    this.loadDevices(design);
                    this.loadConnections(design);

                    this.app.nextId = design.nextId || Math.max(...this.app.devices.map(d => d.id), 0) + 1;
                    this.app.connectionManager.nextConnectionId =
                        design.nextConnectionId || (design.connections ? Math.max(...design.connections.map(c => c.id), 0) + 1 : 1);

                    resolve(true);
                } catch (error) {
                    reject(error);
                }
            };

            reader.onerror = (error) => reject(error);
            reader.readAsText(file);
        });
    }

    clearCurrentDesign() {
        // 清除设备
        this.app.devices.forEach(device => {
            if (device.element.parentNode) {
                device.element.parentNode.removeChild(device.element);
            }
        });
        this.app.devices = [];

        // 清除连接
        this.app.connectionManager.connections.forEach(conn => {
            if (conn.element.parentNode) {
                conn.element.parentNode.removeChild(conn.element);
            }
            if (conn.arrowElement.parentNode) {
                conn.arrowElement.parentNode.removeChild(conn.arrowElement);
            }
        });
        this.app.connectionManager.connections = [];
    }

    // 重构后的 loadDevices
    loadDevices(design) {
        design.devices.forEach(deviceData => {
            try {
                const DeviceClass = DeviceRegistry.getClass(deviceData.type);
                const device = new DeviceClass(
                    deviceData.id,
                    deviceData.x,
                    deviceData.y,
                    deviceData.parameters
                );
                this.app.devices.push(device);
                this.app.canvas.appendChild(device.element);
            } catch (error) {
                console.error(`Failed to load device ${deviceData.id} (${deviceData.type}):`, error);
                // 可选：跳过错误或显示用户提示
            }
        })
    }


    loadConnections(design) {
        design.connections.forEach(connData => {
            const fromDevice = this.app.devices.find(d => d.id === connData.fromDeviceId);
            const toDevice = this.app.devices.find(d => d.id === connData.toDeviceId);

            if (fromDevice && toDevice) {
                const fromPort = fromDevice.ports.find(p => p.type === connData.fromPortType);
                const toPort = toDevice.ports.find(p => p.type === connData.toPortType);

                if (fromPort && toPort) {
                    this.app.connectionManager.createConnection(
                        fromDevice,
                        fromPort,
                        toDevice,
                        toPort
                    );
                }
            }
        });
    }
}