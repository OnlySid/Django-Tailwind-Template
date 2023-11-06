module.exports = {
  content: [
    './templates/**/*.html',
    './static/src/style.css'
  ],
  theme: {
    container: {
      padding: {
        DEFAULT: "1rem",
        sm: "2rem",
        lg: "3rem",
        xl: "4rem",
        "4xl": "8rem",
      },
    },
    extend: {
      fontFamily: {
        'press-start': ['"Press Start 2P"', 'cursive'],
      },
      colors: {
        "primary": "#E94E1E",
        "secondary": "#E94E1E",
        "grey": "#545454",
        "dark": "#202020",
        "light": "#F9FAFB"
      },
    },
    screens: {
      xs: "480px",
      sm: "600px",
      md: "782px",
      lg: "960px",
      xl: "1280px",
      "2xl": "1440px",
      "3xl": "1680px",
      "4xl": "1920px",
    },
  },
  plugins: [],
}

