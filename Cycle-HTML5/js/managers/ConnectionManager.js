export class ConnectionManager {
    constructor(canvas) {
        this.canvas = canvas;
        this.connections = [];
        this.selectedConnection = null;
        this.nextConnectionId = 1;

        // 调试：打印初始化信息
        console.log('ConnectionManager initialized with canvas:', canvas); 
    }

    createConnection(fromDevice, fromPort, toDevice, toPort) {
        console.log('Attempting to create connection:', {
            from: `${fromDevice.type}.${fromPort.type}`,
            to: `${toDevice.type}.${toPort.type}`
        });

        // 检查连接有效性
        if (this.connectionExists(fromDevice, fromPort, toDevice, toPort)) {
            console.warn('Connection already exists');
            return null;
        }

        // 创建连接元素
        const connectionElement = document.createElement('div');
        connectionElement.className = 'connection';
        connectionElement.style.cssText = `
            position: absolute;
            background-color: #0083a9;
            height: 2px;
            transform-origin: 0 0;
            z-index: 5;
            animation: connectionFadeIn 0.5s ease-in-out;
        `;

        const arrowElement = document.createElement('div');
        arrowElement.className = 'connection-arrow';
        arrowElement.style.cssText = `
            position: absolute;
            width: 0;
            height: 0;
            border-left: 6px solid #0083a9;
            border-top: 4px solid transparent;
            border-bottom: 4px solid transparent;
            transform-origin: center;
            z-index: 6;
            animation: connectionFadeIn 0.5s ease-in-out;
        `;

        const connection = {
            id: this.nextConnectionId++,
            element: connectionElement,
            arrowElement: arrowElement,
            fromDevice: fromDevice,
            fromPort: fromPort,
            toDevice: toDevice,
            toPort: toPort
        };

        this.setupConnectionEvents(connection);
        this.updateConnectionPosition(connection);
        this.connections.push(connection);

        // 调试：检查元素是否成功添加
        console.log('Adding elements to canvas:', {
            connection: connectionElement,
            arrow: arrowElement
        });
        
        this.canvas.appendChild(connectionElement);
        this.canvas.appendChild(arrowElement);

        return connection;
    }

    connectionExists(fromDevice, fromPort, toDevice, toPort) {
        return this.connections.some(conn =>
            (conn.fromDevice === fromDevice &&
                conn.fromPort === fromPort &&
                conn.toDevice === toDevice &&
                conn.toPort === toPort) ||
            (conn.fromDevice === toDevice &&
                conn.fromPort === toPort &&
                conn.toDevice === fromDevice &&
                conn.toPort === fromPort)
        );
    }

    setupConnectionEvents(connection) {
        connection.element.addEventListener('mousedown', (e) => {
            this.selectConnection(connection);
            e.stopPropagation();
        });

        connection.arrowElement.addEventListener('mousedown', (e) => {
            this.selectConnection(connection);
            e.stopPropagation();
        });

        // 添加右键删除连接功能
        connection.element.addEventListener('contextmenu', (e) => {
            e.preventDefault();
            this.deleteConnection(connection);
        });

        connection.arrowElement.addEventListener('contextmenu', (e) => {
            e.preventDefault();
            this.deleteConnection(connection);
        });
    }

    updateConnectionPosition(connection) {
        const fromRect = connection.fromPort.element.getBoundingClientRect();
        const toRect = connection.toPort.element.getBoundingClientRect();

        const canvasRect = this.canvas.getBoundingClientRect();

        const fromX = fromRect.left + fromRect.width / 2 - canvasRect.left;
        const fromY = fromRect.top + fromRect.height / 2 - canvasRect.top;
        const toX = toRect.left + toRect.width / 2 - canvasRect.left;
        const toY = toRect.top + toRect.height / 2 - canvasRect.top;

        const length = Math.sqrt(Math.pow(toX - fromX, 2) + Math.pow(toY - fromY, 2));
        const angle = Math.atan2(toY - fromY, toX - fromX) * 180 / Math.PI;

        connection.element.style.width = length + 'px';
        connection.element.style.left = fromX + 'px';
        connection.element.style.top = fromY + 'px';
        connection.element.style.transform = `rotate(${angle}deg)`;

        // 箭头位置
        const arrowX = toX - 6 * Math.cos(angle * Math.PI / 180);
        const arrowY = toY - 6 * Math.sin(angle * Math.PI / 180);

        connection.arrowElement.style.left = arrowX + 'px';
        connection.arrowElement.style.top = arrowY + 'px';
        connection.arrowElement.style.transform = `rotate(${angle}deg)`;
    }

    updateConnectionsForDevice(device) {
        this.connections.forEach(conn => {
            if (conn.fromDevice === device || conn.toDevice === device) {
                this.updateConnectionPosition(conn);
            }
        });
    }

    selectConnection(connection) {
        // 清除之前的选择
        if (this.selectedConnection) {
            this.selectedConnection.element.style.backgroundColor = '#0083a9';
            this.selectedConnection.arrowElement.style.borderLeftColor = '#0083a9';
        }

        this.selectedConnection = connection;

        if (connection) {
            connection.element.style.backgroundColor = 'red';
            connection.arrowElement.style.borderLeftColor = 'red';
        }
    }

    deleteConnection(connection) {
        this.canvas.removeChild(connection.element);
        this.canvas.removeChild(connection.arrowElement);
        this.connections = this.connections.filter(c => c !== connection);
    }

    deleteConnectionsForDevice(device) {
        const connectionsToRemove = this.connections.filter(conn =>
            conn.fromDevice === device || conn.toDevice === device
        );

        connectionsToRemove.forEach(conn => this.deleteConnection(conn));
    }
}

// 添加连接动画效果
const style = document.createElement('style');
style.textContent = `
    @keyframes connectionFadeIn {
        from {
            opacity: 0;
        }
        to {
            opacity: 1;
        }
    }
`;

document.head.appendChild(style);