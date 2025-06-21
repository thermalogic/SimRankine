export class DeviceBase {
    constructor(id, type, x, y) {
        this.id = id;
        this.type = type;
        this.x = x;
        this.y = y;
        this.ports = [];
        this.element = null;
        this.parameters = {};
    }

    createElement(customClass = '') {
        this.element = document.createElement('div');
        this.element.className = `device ${this.type.toLowerCase()} ${customClass}`;

        // 基础设备样式
        this.element.style.cssText = `
            position: absolute;
            display: flex;
            justify-content: center;
            align-items: center;
            font-weight: bold;
            color: #0083a9;
            background-color: white;
            border: 2px solid #0083a9;
            overflow: visible;
            z-index: 10;
            cursor: move;
        `;

        this.element.textContent = `${this.type.split('_')[0]} ${this.id}`;
        this.element.style.left = `${this.x}px`;
        this.element.style.top = `${this.y}px`;
        this.element.dataset.deviceId = this.id;
        return this.element;
    }

    createPort(type, className) {
        const port = {
            element: document.createElement('div'),
            type: type
        };

        port.element.className = `port ${className}`;
        port.element.style.cssText = `
            position: absolute;
            width: 14px;
            height: 14px;
            border-radius: 50%;
            background-color: #0083a9;
            cursor: pointer;
            z-index: 20;
        `;

        this.ports.push(port);
        this.element.appendChild(port.element);
        return port;
    }

    move(x, y) {
        this.x = x;
        this.y = y;
        this.element.style.left = `${x}px`;
        this.element.style.top = `${y}px`;
    }

    move(x, y) {
        this.x = x;
        this.y = y;
        this.element.style.left = `${x}px`;
        this.element.style.top = `${y}px`;
    }

    setupEventListeners() {
        this.element.addEventListener('mousedown', (e) => {
            if (e.target === this.element) {
                this.onDeviceClick(e);
            }
        });

        this.ports.forEach(port => {
            port.element.addEventListener('mousedown', (e) => {
                this.onPortClick(e, port);
            });
        });
    }

    getParameters() {
        return this.parameters;
    }

    updateParameters(params) {
        this.parameters = { ...this.parameters, ...params };
    }
}