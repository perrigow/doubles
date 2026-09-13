/*!
 * SelectNav.js
 * Navigation for small screens
 */

document.getElementById('selectnav-main')
        .addEventListener('change', function(event) {
            window.location = this.value;
        });
