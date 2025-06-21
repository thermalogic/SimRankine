import { DeviceBase } from './DeviceBase.js';

export class Pump extends DeviceBase {
    constructor(id, x, y, parameters = {}) {
        super(id, 'Pump_ph', x, y);
        this.parameters = {
            p_out: parameters.p_out || 10.0,
            ef: parameters.ef || 80.0
        };
        this.initialize();
    }

    initialize() {
        this.createElement('pump');
        this.element.style.cssText += `
            width: 100px;
            height: 100px;
            border-radius: 50%;
        `;

        // 创建端口
        this.createPort('inlet', 'pump-inlet').element.style.cssText = `
            top: 50%;
            right: -7px;
            transform: translateY(-50%);
        `;

        this.createPort('outlet', 'pump-outlet').element.style.cssText = `
            top: 50%;
            left: -7px;
            transform: translateY(-50%);
        `;

        // 添加内部圆环
        const innerCircle = document.createElement('div');
        innerCircle.style.cssText = `
            position: absolute;
            width: 80%;
            height: 80%;
            border: 2px solid #0083a9;
            border-radius: 50%;
        `;
        this.element.appendChild(innerCircle);

        // 添加三角形箭头
        const triangle = document.createElement('div');
        triangle.style.cssText = `
            position: absolute;
            width: 50%;
            height: 50%;
            background-color: #008c48;
            clip-path: polygon(50% 0%, 0% 100%, 100% 100%);
            transform: rotate(90deg);
        `;
        this.element.appendChild(triangle);
           this.setupEventListeners();
    }
}