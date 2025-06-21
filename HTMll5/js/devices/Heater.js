import { DeviceBase } from './DeviceBase.js';

export class Heater extends DeviceBase {
    constructor(id, x, y, parameters = {}) {
        super(id, 'OpenedheaterDw0_ph', x, y);
        this.parameters = {
            p_out: parameters.p_out || 2.0,
            x_out: parameters.x_out || 0.0
        };
        this.initialize();
    }

    initialize() {
        this.createElement('heater');
        this.element.style.cssText += `
            width: 120px;
            height: 100px;
        `;

        // 创建端口
        this.createPort('inletFW', 'heater-fw-inlet').element.style.cssText = `
            right: -7px;
            top: 30%;
        `;

        this.createPort('outletFW', 'heater-fw-outlet').element.style.cssText = `
            left: -7px;
            top: 70%;
        `;

        this.createPort('inletSM', 'heater-sm-inlet').element.style.cssText = `
            top: -7px;
            left: 50%;
            transform: translateX(-50%);
        `;

        // 添加内部矩形
        const innerRect = document.createElement('div');
        innerRect.style.cssText = `
            position: absolute;
            width: 80%;
            height: 60%;
            border: 2px solid #0083a9;
            border-radius: 10px;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
        `;
        this.element.appendChild(innerRect);

        // 添加FW标签
        const label = document.createElement('div');
        label.style.cssText = `
            position: absolute;
            bottom: 10px;
            font-size: 14px;
            color: #0083a9;
        `;
        label.textContent = 'FW';
        this.element.appendChild(label);
        this.setupEventListeners();
    }
}