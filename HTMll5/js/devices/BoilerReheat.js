import { DeviceBase } from './DeviceBase.js';

export class BoilerReheat extends DeviceBase {
    constructor(id, x, y, parameters = {}) {
        super(id, 'BoilerReheat', x, y);
        this.parameters = {
            p_out: parameters.p_out || 15.0,
            x_out: parameters.x_out || 1.0,
            t_out: parameters.t_out || 300.0,
            x_flow_out: parameters.x_flow_out || 1.0,
            t_ouletRH: parameters.t_ouletRH || 400.0,
            p_ouletRH: parameters.p_ouletRH || 3.0
        };
        this.initialize();
    }

    initialize() {
        this.createElement('reheat-boiler');
        // 设置固定尺寸（如果CSS未生效）
        this.element.style.width = '120px';
        this.element.style.height = '160px';

        // 添加火焰效果
        const flame = document.createElement('div');
        flame.className = 'flame';
        this.element.appendChild(flame);

        // 创建并定位端口
        this.createPort('inlet', 'boiler-reheat-inlet').element.style.cssText = `
            bottom: 10px;
            left: 30%;
            transform: translateX(-50%);
        `;

        this.createPort('outlet', 'boiler-reheat-outlet').element.style.cssText = `
            top: 10px;
            left: 30%;
            transform: translateX(-50%);
        `;

        this.createPort('inletRH', 'boiler-reheat-rh-inlet').element.style.cssText = `
            bottom: 10px;
            left: 70%;
            transform: translateX(-50%);
        `;

        this.createPort('outletRH', 'boiler-reheat-rh-outlet').element.style.cssText = `
            top: 10px;
            left: 70%;
            transform: translateX(-50%);
        `;
        this.setupEventListeners();
    }
}