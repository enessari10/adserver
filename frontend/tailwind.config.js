/** @type {import('tailwindcss').Config} */
export default {
  content: [
    './index.html',
    './src/**/*.{js,jsx,ts,tsx}',
  ],
  theme: {
    extend: {
      colors: {
        brand: {
          50: '#fff3ec',
          100: '#ffe6d8',
          200: '#ffc8aa',
          300: '#ffa27a',
          400: '#ff834f',
          500: '#eb6215',
          600: '#d85a13',
          700: '#b64a0f',
          800: '#953b0c',
          900: '#6b2908',
          DEFAULT: '#eb6215'
        },
      },
    },
  },
  plugins: [],
}


