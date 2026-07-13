require("cairo")

function conky_draw_clock_box()
	if conky_window == nil then
		return
	end

	local cs = cairo_xlib_surface_create(
		conky_window.display,
		conky_window.drawable,
		conky_window.visual,
		conky_window.width,
		conky_window.height
	)

	local cr = cairo_create(cs)

	cairo_set_source_rgba(cr, 1, 1, 1, 0.85)

	cairo_set_line_width(cr, 2)

	cairo_rectangle(cr, 0, 0, 540, 220)

	cairo_stroke(cr)

	cairo_destroy(cr)
	cairo_surface_destroy(cs)
end

function conky_draw_music_box()
	if conky_window == nil then
		return
	end

	local cs = cairo_xlib_surface_create(
		conky_window.display,
		conky_window.drawable,
		conky_window.visual,
		conky_window.width,
		conky_window.height
	)

	local cr = cairo_create(cs)

	cairo_set_source_rgba(cr, 0, 0, 0, 0.28)
	cairo_rectangle(cr, 0, 0, 390, 330)
	cairo_fill(cr)

	cairo_set_source_rgba(cr, 1, 1, 1, 0.85)
	cairo_set_line_width(cr, 2)
	cairo_rectangle(cr, 0, 0, 390, 330)
	cairo_stroke(cr)

	cairo_destroy(cr)
	cairo_surface_destroy(cs)
end
