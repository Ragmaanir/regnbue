require "./spec_helper"

describe Regnbue do
  test "format_large_number" do
    assert Regnbue.format_large_number(0) == "0"
    assert Regnbue.format_large_number(300) == "300"
    assert Regnbue.format_large_number(1300) == "1,300"
    assert Regnbue.format_large_number(100300) == "100,300"
    assert Regnbue.format_large_number(1234567) == "1,234,567"

    assert Regnbue.format_large_number(1300, "--") == "1--300"
  end

  test "format_string with simple strings" do
    assert Regnbue.format_string({:white, ""}) == "".colorize(:white).to_s
    assert Regnbue.format_string({:white, "sentence"}) == "sentence".colorize(:white).to_s
  end

  test "format_string with nested strings" do
    str = Regnbue.format_string({
      :white,
      "This is ",
      {:yellow,
        "the ",
        {:red, "last "},
        "warning ",
      },
      "for all of ",
      {:red, "you!"},
    })

    expected = [
      "This is ".colorize(:white),
      [
        "the ".colorize(:yellow),
        "last ".colorize(:red),
        "warning ".colorize(:yellow),
      ].join,
      "for all of ".colorize(:white),
      "you!".colorize(:red),
    ].join

    assert str == expected
  end
end
