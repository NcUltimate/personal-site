Background = {
  initialize: ->
    this.svg = d3.select('#background')
    this.initGrid()

  initGrid: ->
    lines = this.svg.selectAll('grid-line')
            .data(this.gridPoints())
            .enter()
            .append('line')

    lines.attr('x1', (d) -> return d[0])
          .attr('y1', (d) -> return d[1])
          .attr('x2', (d) -> return d[2])
          .attr('y2', (d) -> return d[3])
          .attr('stroke', '#e5e5e5')
          .classed('grid-line', true)

  gridPoints: ->
    endpoints = []
    size      = 20
    for j in [0..size]
      perc = (100 / size)*j + '%'
      perc2 = (50 / size)*j + '%'
      endpoints.push([perc, '0%', '0%', perc2])
      endpoints.push([perc2, '100%', '100%', perc])

    return endpoints


}
$.jklemen = $.extend($.jklemen, { 'Background' : Background })