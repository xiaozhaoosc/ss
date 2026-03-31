/** @type {import('tailwindcss').Config} */
module.exports = {
    content: [
        './src/pages/**/*.{vue,js,ts,jsx,tsx}',
        './src/components/**/*.{vue,js,ts,jsx,tsx}',
        './src/App.vue'
    ],
    darkMode: 'class',
    theme: {
        extend: {
            colors: {
                // 家长端配色 (Cognitive Ease)
                'parent-primary': '#6C9BD2',
                'parent-primary-dark': '#5a82b0',
                'parent-bg-light': '#f6f7f8',
                'parent-bg-dark': '#14191e',
                'parent-surface-light': '#ffffff',
                'parent-surface-dark': '#1e242b',

                // 儿童端配色 (Emotional Warmth)
                'child-mint': '#8CD0A1',
                'child-yellow': '#F5D76E',
                'child-indigo': '#6366f1',
                'child-bg-light': '#f0fdf4',
                'child-bg-dark': '#1e293b'
            },
            fontFamily: {
                'parent': ['Manrope', 'Inter', 'sans-serif'],
                'child': ['Nunito', 'sans-serif']
            },
            borderRadius: {
                'xl': '0.75rem',
                '2xl': '1rem',
                '3xl': '1.5rem'
            }
        }
    },
    plugins: [],
    // uni-app 小程序适配
    corePlugins: {
        preflight: false
    }
}
