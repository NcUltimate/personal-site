Menu = {
  pulse: null,
  buttonRadius: 35,
  menuRadius: 140,
  menuWidth: 400,
  menuNames: ['CV', 'GitHub', 'Projects', 'Sites', 'Etc.', 'Blog', 'Bio'],
  
  initialize: ->
    this.svg = d3.select('#menu')
                  .attr('width', this.menuWidth)
                  .attr('height', this.menuWidth)

    this.menus = $.map this.menuNames, (m, idx) -> [[m,idx]]
    this.initMenuCircle()
    this.initMenuButtons()
    this.initMenuTitles()
    this.initSiteName()
    this.animate()

  animate: ->
    TweenLite.from($('#menu'), 1, {
      opacity: 0,
      rotation: 15,
      transformOrigin: 'center center'
    })
    TweenLite.from($('.sitename'), 1, {
      opacity: 0,
      rotation: -15,
      transformOrigin: 'center center'
    })

    t0 = new TimelineMax()
    t0.staggerFrom($('.menu-circle'), 1, {
      scale: 0,
      x: this.menuRadius,
      y: this.menuRadius
    }, 0.2)
    t0.staggerFrom($('.menu-title'), 0.4, {
      scale: 0,
      opacity: 0,
      x: 50,
      y: 100
    }, 0.2)

    t1 = new TimelineMax()
    t1.staggerFrom($('.menu-button'), 0.5, {
      scale: 0.2,
      opacity: 0.2,
      rotation: -90,
      transformOrigin: 'center center'
    }, 0.1)

    this.pulse = new TimelineMax({repeat: -1})
    this.pulse.staggerTo($('.menu-button'), 0.2, {
      yoyo: true, 
      repeat: 1,
      scale: 0.7,
      delay: 8
    }, 0.2)


  initMenuTitles: ->
    text = this.svg.selectAll('textpath')
            .data([['My Work', '#menupath1'], ['My Self', '#menupath2']])
            .enter()
            .append('text')
            
    text.attr('fill', '#555')
        .attr('font-size', '22')
        .classed('menu-title', true)
        
    textPath = text.append('textPath')
                  .attr('xlink:href', (d) -> return d[1])
                  .text((d) -> return d[0])

  initMenuCircle: ->
    menuCircle = this.svg.selectAll('menu-circle')
        .data([[this.menuRadius + 5, 1], [this.menuRadius, 2]])
        .enter()
        .append('circle')

    menuCircle.attr('cx', this.menuWidth / 2)
              .attr('cy', this.menuWidth / 2)
              .attr('r', (d) -> return d[0])
              .attr('fill', '#eee')
              .attr('stroke-width', (d) -> return d[1])
              .attr('stroke', '#ccc')
              .classed('menu-circle', true)

  initSiteName: ->
    siteName = this.svg.selectAll('sitename')
                      .data(["JoeKle.men"])
                      .enter()
                      .append('text')
    siteName.text((d) -> return d)
            .attr('fill', 'black')
            .attr('x', this.menuWidth / 2 - 65)
            .attr('y', this.menuWidth / 2)
            .style('font-size', '26px')
            .classed('sitename', true)

    subtitle = this.svg.selectAll('subtitle')
                      .data(["UI/UX Developer"])
                      .enter()
                      .append('text')
    subtitle.text((d) -> return d)
            .attr('fill', '#555')
            .attr('x', this.menuWidth / 2 - 65)
            .attr('y', this.menuWidth / 2 + 20)
            .style('font-size', '16px')
            .classed('sitename', true)

  initMenuButtons: ->
    site = this
    buttons = this.svg.selectAll('menu-button')
                .data(this.menus)
                .enter()
                .append('g')
                .classed('menu-button', true)
                .on 'mouseover', (e) ->
                  d3.selectAll('.menu-circle')
                    .transition()
                    .ease('cubic-out').attr('stroke', '#555')

                  c = d3.select(this).select('circle')
                  c.transition()
                    .ease('cubic-out')
                    .attr('r', site.buttonRadius + 10)
                    .attr('stroke-width', 3)
                  site.pulse.seek(0)

                .on 'mouseout', (e) ->
                  d3.selectAll('.menu-circle')
                    .transition()
                    .ease('cubic-out').attr('stroke', '#ccc')

                  c = d3.select(this).select('circle')
                  c.transition()
                    .ease('cubic-out')
                    .attr('r', site.buttonRadius)
                    .attr('stroke-width', 1)
                  site.pulse.play()

    rad  = @buttonRadius
    buttons.append('circle')
            .attr('cx', (d) -> return site.buttonPosition(d[1])[0])
            .attr('cy', (d) -> return site.buttonPosition(d[1])[1])
            .attr('r', rad)
            .attr('fill', '#eee')
            .attr('stroke', '#555')

    buttons.append('text')
            .attr('x', (d) -> return site.textPosition(site, d[1])[0])
            .attr('y', (d) -> return site.textPosition(site, d[1])[1])
            .attr('fill', '#333')
            .text( (d) -> return d[0] )

  buttonPosition: (idx) ->
    ridx  = idx % (@menus.length / 2) + 1
    angle = -180 / ( @menus.length / 2 + 1 )
    start = ridx * angle + 90
    start += if idx < @menus.length/2 then 180 else 0

    cx = this.menuWidth / 2
    cy = this.menuWidth / 2
    x = cx + Math.cos(this.toRad(start)) * @menuRadius
    y = cy + Math.sin(this.toRad(start)) * @menuRadius

    return [x, y]

  textPosition: (site, idx) ->
    bpos = site.buttonPosition(idx)
    x = bpos[0] - 10 - 2*this.menuNames[idx].length
    y = bpos[1] + 5

    return [x,y]

  toRad: (deg) ->
    return deg * Math.PI / 180
}

$.jklemen = $.extend($.jklemen, { 'Menu' : Menu })
