import { DeviceBase } from './DeviceBase.js';

export class TurbineSimple extends DeviceBase {
    constructor(id, x, y, parameters = {}) {
        super(id, 'Turbine_ph', x, y);
        this.parameters = {
            p_out: parameters.p_out || 1.0,
            ef: parameters.ef || 80.0
        };
        this.initialize();
    }

    initialize() {
        this.createElement('turbine-simple');
        this.element.style.cssText += `
            width: 120px;
            height: 120px;
            clip-path: polygon(0% 25%, 100% 35%, 100% -35%, 0% -25%);
        `;

        // 创建端口
        this.createPort('inlet', 'turbine-inlet').element.style.cssText = `
            top: 50%;
            right: -7px;
            transform: translateY(-50%);
        `;

        this.createPort('outlet', 'turbine-outlet').element.style.cssText = `
            top: 50%;
            left: -7px;
            transform: translateY(-50%);
        `;
        this.setupEventListeners();
    }
}