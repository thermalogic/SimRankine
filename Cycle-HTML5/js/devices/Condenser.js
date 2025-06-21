import { DeviceBase } from './DeviceBase.js';

export class Condenser extends DeviceBase {
    constructor(id, x, y, parameters = {}) {
        super(id, 'Condenser_ph', x, y);
        this.parameters = {
            p_out: parameters.p_out || 0.1,
            x_out: parameters.x_out || 0.0
        };
        this.initialize();
    }

    initialize() {
        this.createElement('condenser');
        this.element.style.cssText += `
            width: 100px;
            height: 160px;
        `;

        // 创建端口
        this.createPort('inlet', 'condenser-inlet').element.style.cssText = `
            top: 20%;
            right: -7px;
            transform: translateY(-50%);
        `;

        this.createPort('outlet', 'condenser-outlet').element.style.cssText = `
            bottom: 20%;
            right: -7px;
            transform: translateY(50%);
        `;

        // 添加冷凝器条纹
        const stripes = document.createElement('div');
        stripes.style.cssText = `
            position: absolute;
            top: 30px;
            left: 0;
            right: 0;
            height: 100px;
            background-image: linear-gradient(
                to right,
                transparent 10%,
                #008c48 10%,
                #008c48 20%,
                transparent 20%,
                transparent 30%,
                #008c48 30%,
                #008c48 40%,
                transparent 40%,
                transparent 50%,
                #008c48 50%,
                #008c48 60%,
                transparent 60%,
                transparent 70%,
                #008c48 70%,
                #008c48 80%,
                transparent 80%,
                transparent 90%,
                #008c48 90%,
                #008c48 100%
            );
        `;
        this.element.appendChild(stripes);
          this.setupEventListeners(); 
    }
}