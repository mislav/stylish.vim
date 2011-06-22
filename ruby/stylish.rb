# yay Stylish!
class Stylish
  attr_reader :current_scheme

  def initialize
    @current_scheme = vim('g:colors_name').to_s.downcase
    @current_font, font_size = vim('&guifont').to_s.split(':h')
    @font_size = font_size ? font_size.to_i : 11
  end

  def available_schemes
    @available_schemes ||= vim('&runtimepath').to_s.split(',').map do |path|
      dir = File.join(path, 'colors')
      Dir.glob File.join(dir, '*.vim') if File.directory? dir
    end.compact.flatten.
      map { |file| File.basename(file, '.vim') }.sort.uniq
  end

  # TODO: support for other than OS X
  def available_fonts
    @available_fonts ||= begin
      prefixes = ["", "/System", ENV['HOME']]
      Dir[*prefixes.map {|p| "#{p}/Library/Fonts/*" }].map do |font|
        File.basename(font).sub(/\.\w{2,4}$/, '')
      end.sort.uniq
    end
  end

  FONTS = [ "Andale Mono", "Anonymous Pro", "Courier New",
            "DejaVu Sans Mono", "Inconsolata", "Menlo", "Monaco" ]

  # available monospace fonts on the system
  def monospace_fonts
    @monospace_fonts ||= FONTS.select do |name|
      re = Regexp.new(name.gsub(' ', ' ?'), 'i')
      available_fonts.grep(re).any?
    end
  end

  def next_scheme(offset = 1)
    idx = offset_index(available_schemes, @current_scheme, offset)
    available_schemes[idx]
  end

  def set_scheme(scheme)
    @current_scheme = scheme
    vim_cmd ":color #{scheme}"
    vim_echo "color scheme: #{scheme}"
  end

  def next!
    set_scheme next_scheme
  end

  def previous!
    set_scheme next_scheme(-1)
  end

  def rand!
    if !defined?(@visited_schemes) or @visited_schemes.size >= available_schemes.size
      @visited_schemes = [@current_scheme]
    end
    begin
      idx = Kernel.rand available_schemes.size
      scheme = available_schemes[idx]
    end while @visited_schemes.include? scheme
    @visited_schemes << scheme
    set_scheme scheme
  end

  def next_font(offset = 1)
    idx = offset_index(monospace_fonts, @current_font, offset)
    monospace_fonts[idx]
  end

  def next_font!
    set_font next_font
  end

  def previous_font!
    set_font next_font(-1)
  end

  def set_guifont(name, size)
    vim_cmd ":set guifont=#{name.gsub(' ', '\ ')}:h#{size}"
  end

  def set_font(name)
    @current_font = name
    set_guifont name, @font_size
    vim_echo "font: #{name}"
  end

  def set_font_size(size)
    @font_size = size.to_i
    set_guifont @current_font, @font_size
  end

  private

  def vim(expression)
    ::VIM.evaluate(expression)
  end

  def vim_cmd(cmd)
    ::VIM.command(cmd)
  end

  def vim_echo(msg)
    vim_cmd ":redraw | echo #{msg.inspect}"
  end

  # Finds the index of `item` in `array` and offsets it by the given `offset`,
  # wrapping the number to the other end of the array if needed.
  def offset_index(array, item, offset)
    if idx = array.index(item)
      idx += offset
      if idx >= array.size then idx = idx - array.size
      elsif idx < 0 then idx = array.size + idx
      end
      idx
    else
      0
    end
  end
end
