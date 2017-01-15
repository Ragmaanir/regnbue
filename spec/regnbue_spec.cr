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

  test "tuple entries have to be enclosed in parentheses" do
    assert Regnbue.format_string({:green, "%-3d" % 5}) == "5  ".colorize(:green).to_s
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

  test "format_string with conditions" do
    str1 = Regnbue.format_string({
      (:red if 1 > 5),
      "ohoh!",
    })

    str2 = Regnbue.format_string({
      (:red if 1 > 0),
      "ohoh!",
    })

    assert str1 == "ohoh!".colorize(:white).to_s
    assert str2 == "ohoh!".colorize(:red).to_s
  end

  test "uncoloring" do
    assert Regnbue.uncolor("test".colorize(:red).to_s) == "test"

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
    assert Regnbue.uncolor(str) == "This is the last warning for all of you!"
  end
end
