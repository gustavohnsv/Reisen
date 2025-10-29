// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails

import "@hotwired/turbo-rails"
import "controllers"
import "bootstrap"

const THEME_KEY = 'user-theme';
const LIGHT_ICON = 'bi-sun-fill';
const DARK_ICON = 'bi-moon-fill';

function updateIcon(iconElement, theme) {
    if (theme === 'dark') {
        iconElement.classList.remove(LIGHT_ICON);
        iconElement.classList.add(DARK_ICON);
    } else {
        iconElement.classList.remove(DARK_ICON);
        iconElement.classList.add(LIGHT_ICON);
    }
}

function setTheme(theme) {
    const htmlElement = document.documentElement;
    const themeIcon = document.getElementById('theme-icon');

    if (theme === 'auto') {
        htmlElement.removeAttribute('data-bs-theme');
        localStorage.removeItem(THEME_KEY);

        const systemTheme = window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light';
        if (themeIcon) updateIcon(themeIcon, systemTheme);

    } else {
        htmlElement.setAttribute('data-bs-theme', theme);
        localStorage.setItem(THEME_KEY, theme);
        if (themeIcon) updateIcon(themeIcon, theme);
    }
}

function toggleTheme() {
    const htmlElement = document.documentElement;
    let currentTheme = htmlElement.getAttribute('data-bs-theme');

    if (!currentTheme) {
        currentTheme = window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light';
    }

    const newTheme = currentTheme === 'dark' ? 'light' : 'dark';
    setTheme(newTheme);
}

document.addEventListener('turbo:load', () => {
    const savedTheme = localStorage.getItem(THEME_KEY);
    setTheme(savedTheme || 'auto');

    const toggleButton = document.getElementById('theme-toggle');

    if (toggleButton && !toggleButton.dataset.listenerAttached) {
        toggleButton.addEventListener('click', toggleTheme);
        toggleButton.dataset.listenerAttached = 'true';
    }
});

document.addEventListener("turbo:load", () => {

    const toastElements = document.querySelectorAll('.toast');
    toastElements.forEach(toastEl => {

        const toast = new bootstrap.Toast(toastEl, {
            autohide: true,
            delay: 5000
        });

        toast.show();
    });
});