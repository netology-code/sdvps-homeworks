window.onload = () => {
    'use strict';
    // Define keys to insert
    const keys = [
        { name: 'up', key: 'arrowup', text: '🔼' },
        { name: 'left', key: 'arrowleft', text: '◀️'},
        { name: 'down', key: 'arrowdown', text: '🔽'},
        { name: 'right', key: 'arrowright', text: '▶️'},
        { name: 'restart', key: 'r', text: '↺'}
    ];

    const controlsElement = document.getElementById('controls');
    const canvasElement = document.getElementById('game-canvas');
    controlsElement.style.display = 'none';
    
    const appendButton = (element, key) => {
        const button = document.createElement('button'); 
        button.innerHTML = key.text;
        button.className = 'control-button';
        button.id = 'control-button-' + key.name;
        button.addEventListener('mousedown', () => {
            canvasElement.focus();
            canvasElement.dispatchEvent(
                new KeyboardEvent('keydown', { 
                    'key': key.key
                })
            );
        });
        element.appendChild(button);
    };

    // Insert keys to document
    keys.forEach(key => appendButton(controlsElement, key));

    // Hide keys, if browser is (probably) not mobile
    const isMobile = () => {
        const ua = window.navigator.userAgent;
        // if useragent string contains any of the strings below, browser is considered mobile
        return ['Android', 'iPhone', 'iPad', 'iPod', 'IEMobile'].map(keyword => ua.includes(keyword)).includes(true);
    };

    const controlsToggleElement = document.getElementById('controls-toggle');

    const toggleControls = () => {
        if (controlsElement.style.display == 'none') {
            controlsToggleElement.innerHTML = 'Hide mobile controls';
            controlsElement.style.display = 'grid';
        } else {
            controlsToggleElement.innerHTML = 'Show mobile controls';
            controlsElement.style.display = 'none';
        }
    };
    if (isMobile()) {
        toggleControls();
    }
    controlsToggleElement.addEventListener('click', toggleControls);
    controlsToggleElement.style.display = 'block';
};
