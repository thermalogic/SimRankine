// DeviceRegistry.js
export class DeviceRegistry {
    static classMap = new Map();

    // 从JSON配置动态注册所有设备
    static async initFromConfig(configPath = '../configs/device-mappings.json') {
        const response = await fetch(configPath);
        const { mappings } = await response.json();

        for (const { type, path, className } of mappings) {
            await this.registerDynamic(type, path, className);
        }
    }

    // 动态加载并注册单个设备类
    static async registerDynamic(type, modulePath, className) {
        try {
            const module = await import(modulePath);
            this.register(type, module[className]);
            console.log(`[DeviceRegistry] 成功注册: ${type} -> ${className}`);
        } catch (error) {
            console.error(`[DeviceRegistry] 注册失败: ${type}`, error);
        }
    }

    // 静态注册（兼容旧代码）
    static register(type, classRef) {
        this.classMap.set(type, classRef);
    }

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