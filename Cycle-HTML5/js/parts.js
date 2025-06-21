// 定义设备基类
class Device {
    constructor(name) {
        this.name = name;
    }

    // 抽象方法，子类需要实现
    simulate() {
        throw new Error('simulate method must be implemented in subclass');
    }
}

// 定义锅炉类
class Boiler extends Device {
    constructor(name, inletPressure, outletPressure) {
        super(name);
        this.inletPressure = inletPressure;
        this.outletPressure = outletPressure;
    }

    simulate() {
        // 简单模拟，实际需要根据物理模型实现
        console.log(`${this.name} 模拟：入口压力 ${this.inletPressure} MPa，出口压力 ${this.outletPressure} MPa`);
    }
}

// 定义涡轮机类
class Turbine extends Device {
    constructor(name, inletEnthalpy, outletEnthalpy) {
        super(name);
        this.inletEnthalpy = inletEnthalpy;
        this.outletEnthalpy = outletEnthalpy;
    }

    simulate() {
        // 简单模拟，实际需要根据物理模型实现
        console.log(`${this.name} 模拟：入口焓 ${this.inletEnthalpy} kJ/kg，出口焓 ${this.outletEnthalpy} kJ/kg`);
    }
}

// 定义泵类
class Pump extends Device {
    constructor(name, inletPressure, outletPressure) {
        super(name);
        this.inletPressure = inletPressure;
        this.outletPressure = outletPressure;
    }

    simulate() {
        // 简单模拟，实际需要根据物理模型实现
        console.log(`${this.name} 模拟：入口压力 ${this.inletPressure} MPa，出口压力 ${this.outletPressure} MPa`);
    }
}

// 定义冷凝器类
class Condenser extends Device {
    constructor(name, heatTransferRate) {
        super(name);
        this.heatTransferRate = heatTransferRate;
    }

    simulate() {
        // 简单模拟，实际需要根据物理模型实现
        console.log(`${this.name} 模拟：热传递率 ${this.heatTransferRate} kJ/kg`);
    }
}