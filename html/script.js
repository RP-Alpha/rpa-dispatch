window.addEventListener('message', (event) => {
    const data = event.data;
    if (data.action === 'alert') {
        createAlert(data.data);
    }
});

function createAlert(data) {
    const container = document.getElementById('dispatch-container');

    // limit max alerts
    if (container.children.length > 4) {
        container.removeChild(container.firstChild); // Remove oldest
    }

    const alert = document.createElement('div');
    const typeClass = data.job === 'ambulance' ? 'type-ambulance' : 'type-police';

    alert.className = `dispatch-alert ${typeClass}`;

    alert.innerHTML = `
        <div class="alert-header">
            <span class="alert-code">${data.code || '10-00'}</span>
            <span class="alert-title">${data.title}</span>
        </div>
        <div class="alert-info">
            <i class="fa-solid fa-location-dot"></i>
            <span>${data.location}</span>
        </div>
        ${data.message ? `
        <div class="alert-info">
            <i class="fa-solid fa-circle-info"></i>
            <span>${data.message}</span>
        </div>` : ''}
        <div class="alert-timer" style="width: 100%"></div>
    `;

    container.appendChild(alert);

    // Timer animation
    const timer = alert.querySelector('.alert-timer');
    const duration = 10000; // 10s

    // Use transition for smooth bar
    setTimeout(() => {
        timer.style.transition = `width ${duration}ms linear`;
        timer.style.width = '0%';
    }, 50);

    setTimeout(() => {
        alert.style.animation = 'slideOut 0.5s ease-in forwards';
        setTimeout(() => alert.remove(), 500);
    }, duration);
}

// Add CSS keyframe for exit
const style = document.createElement('style');
style.innerHTML = `
@keyframes slideOut {
    to { transform: translateX(110%); opacity: 0; }
}
`;
document.head.appendChild(style);
