module.exports = class Audio

  dancer: {}

  constructor:(@dom)->

    @dancer = new Dancer

    @dancer.between 0, 11, ()->

      # console.log this.getFrequency(0)

    @dancer.load { src: 'audio/wind-howl.mp3', loop:true }

    @dancer.play()

  spectrum:->

    @dancer.getSpectrum()