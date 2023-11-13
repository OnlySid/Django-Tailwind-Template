module.exports = {
  content: [
    './templates/*.html',
    /* Any additional Django Apps */
    './*/templates/**/*.html',
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
      transitionDuration: {
        DEFAULT: "500ms",
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
      xs: "480px", // ^ Small Mobile
      sm: "600px", // ^ Mobile
      md: "782px", // ^ Large Mobile / Small Tablet (Full mobile menu)
      lg: "960px", // ^ Tablet (Partial mobile menu should probably be implemented here)
      xl: "1280px", // ^ Small Laptop
      "2xl": "1440px", // ^ Laptop
      "3xl": "1680px", // ^ Desktop / Large Laptop
      "4xl": "1920px", // ^ Desktop
    },
  },
  plugins: [],
}

