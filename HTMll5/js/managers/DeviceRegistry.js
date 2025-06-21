// DeviceRegistry.js
export class DeviceRegistry {
    static classMap = new Map();  // 存储设备类型与类的映射

    // 注册设备类
    static register(type, classRef) {
        if (!type || !classRef) {
            throw new Error("Device type and class reference must be provided.");
        }
        this.classMap.set(type, classRef);
    }

    // 获取设备类
    static getClass(type) {
        if (!this.classMap.has(type)) {
            throw new Error(`Device type "${type}" is not registered.`);
        }
        return this.classMap.get(type);
    }

    // 批量注册（可选）
    static registerAll(devices) {
        Object.entries(devices).forEach(([type, classRef]) => {
            this.register(type, classRef);
        });
    }
}