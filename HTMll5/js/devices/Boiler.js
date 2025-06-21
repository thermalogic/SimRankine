import { DeviceBase } from './DeviceBase.js';

export class Boiler extends DeviceBase {
    constructor(id, x, y, parameters = {}) {
        super(id, 'Boiler_ph', x, y);
        this.parameters = {
            p_out: parameters.p_out || 15.0,
            x_out: parameters.x_out || 1.0,
            t_out: parameters.t_out || 300.0,
            x_flow_out: parameters.x_flow_out || 1.0
        };
        this.initialize();
    }

    initialize() {
        this.createElement('boiler');
        this.element.style.cssText += `
            width: 120px;
            height: 160px;
        `;

        // 添加火焰效果
        const flame = document.createElement('div');
        flame.style.cssText = `
            position: absolute;
            width: 30px;
            height: 40px;
            background-color: #ee2e2f;
            clip-path: polygon(50% 0%, 0% 100%, 100% 100%);
            top: 50px;
            left: 50%;
            transform: translateX(-50%);
        `;
        this.element.appendChild(flame);

        // 创建端口
        this.createPort('inlet', 'boiler-inlet').element.style.cssText = `
            bottom: 20px;
            left: 50%;
            transform: translateX(-50%);
        `;

        this.createPort('outlet', 'boiler-outlet').element.style.cssText = `
            top: 20px;
            left: 50%;
            transform: translateX(-50%);
        `;

        // 添加底部圆形
        const bottomCircle = document.createElement('div');
        bottomCircle.style.cssText = `
            position: absolute;
            width: 80px;
            height: 80px;
            border: 2px solid #0083a9;
            border-radius: 50%;
            bottom: 20px;
            left: 50%;
            transform: translateX(-50%);
        `;
        this.element.appendChild(bottomCircle);
         this.setupEventListeners();
    }
}