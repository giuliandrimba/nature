module.exports = (srcwidth, srcheight, targetwidth, targetheight, fLetterBox) ->
  result =
    width: 0
    height: 0
    fScaleToTargetWidth: true

  return result  if (srcwidth <= 0) or (srcheight <= 0) or (targetwidth <= 0) or (targetheight <= 0)

  # scale to the target width
  scaleX1 = targetwidth
  scaleY1 = (srcheight * targetwidth) / srcwidth

  # scale to the target height
  scaleX2 = (srcwidth * targetheight) / srcheight
  scaleY2 = targetheight

  # now figure out which one we should use
  fScaleOnWidth = (scaleX2 > targetwidth)

  if fScaleOnWidth
    fScaleOnWidth = fLetterBox
  else
    fScaleOnWidth = not fLetterBox

  if fScaleOnWidth
    result.width = Math.floor(scaleX1)
    result.height = Math.floor(scaleY1)
    result.fScaleToTargetWidth = true
  else
    result.width = Math.floor(scaleX2)
    result.height = Math.floor(scaleY2)
    result.fScaleToTargetWidth = false
  result.targetleft = Math.floor((targetwidth - result.width) / 2)
  result.targettop = Math.floor((targetheight - result.height) / 2)
  result
