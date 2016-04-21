Embroidery = {
  initialize: ->
    this.svg = d3.select('#embroidery')
    this.initStripes()
    this.animate()

  animate: ->
    $.each $('.stripe'), (idx, s) ->
      TweenLite.from(s, 0.6, {
        scale: 0,
        delay: idx % 3 * 0.1 + 0.6,
        x:     if idx < 3 then 200 else 0
      })

  initStripes: ->
    lines = this.svg.selectAll('stripe')
            .data([
              [ '5%','40%','30%','40%'],
              ['10%','50%','31%','50%'],
              ['15%','60%','32%','60%'],
              ['70%','40%','95%','40%'],
              ['69%','50%','90%','50%'],
              ['68%','60%','85%','60%']
            ])
            .enter()
            .append('g')
            .classed('stripe', true)

    lines.append('line')
          .attr('x1', (d) -> return d[0])
          .attr('y1', (d) -> return d[1])
          .attr('x2', (d) -> return d[2])
          .attr('y2', (d) -> return d[3])
          .attr('stroke', '#aaa')

    lines.append('circle')
          .attr('cx', (d, i) -> return d[2*Math.floor(i/3)])
          .attr('cy', (d, i) -> return d[2*Math.floor(i/3)+1])
          .attr('r', 2)
          .attr('fill', '#555')
}
$.jklemen = $.extend($.jklemen, { 'Embroidery' : Embroidery })