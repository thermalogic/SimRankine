import { DeviceBase } from './DeviceBase.js';

export class TurbineEx1 extends DeviceBase {
    constructor(id, x, y, parameters = {}) {
        super(id, 'TurbineEx1_ph', x, y);
        this.parameters = {
            p_out: parameters.p_out || 1.0,
            p_ex: parameters.p_ex || 0.5,
            ef: parameters.ef || 80.0
        };
        this.initialize();
    }

    initialize() {
        this.createElement('turbine-ex');
        this.element.style.cssText += `
            width: 120px;
            height: 160px;
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

        this.createPort('exlet', 'turbine-exlet').element.style.cssText = `
            top: 75%;
            left: 50%;
            transform: translate(-50%, -50%);
        `;

        // 添加内部线条
        const line1 = document.createElement('div');
        line1.style.cssText = `
            position: absolute;
            width: 80%;
            height: 2px;
            background-color: #0083a9;
            top: 40%;
            left: 10%;
            transform: rotate(15deg);
        `;
        this.element.appendChild(line1);

        const line2 = document.createElement('div');
        line2.style.cssText = `
            position: absolute;
            width: 80%;
            height: 2px;
            background-color: #0083a9;
            top: 60%;
            left: 10%;
            transform: rotate(-15deg);
        `;
        this.element.appendChild(line2);
        this.setupEventListeners();
    }
}