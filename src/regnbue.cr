require "./regnbue/*"

module Regnbue
  COLOR_REGEX = %r{\e\[\d\d?m}

  # Regnbue.format_large_number(1234567)
  # #=> "1,234,567"
  def self.format_large_number(number, separator : String = ",")
    number.to_s.reverse.gsub(/(\d{3})(?=.)/, "\\1#{separator}").reverse
  end

  def self.uncolor(str : String)
    str.gsub(COLOR_REGEX, "")
  end

  # Takes a tuple of the form:
  #   {color, arg1, arg2, **args }
  # where arg1, arg2, ... are either things that can
  # be converted to a string or another tuple in the above format.
  # So nesting of tuples is possible and also the main purpose.
  # Nesting makes it possible to colorize portions of a text in a
  # very simple way.
  macro format_string(tuple)
    {%
      color = tuple[0]
      output = [] of String
    %}
    {% for e, i in tuple %}
      {% if i > 0 %}
        {% if e.is_a?(TupleLiteral) %}
          {% output << "Regnbue.format_string(#{e})" %}
        {% else %}
          {% output << "(#{e}).colorize((#{color}) || :white)" %}
        {% end %}
      {% end %}
    {% end %}

    {% output = output.join(",") %}

    {% res = "[" + output + "]" + ".join" %}

    {{res.id}}
  end
end
