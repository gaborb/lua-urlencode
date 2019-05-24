local lib = require("src.lib")

describe("urlencode", function()
    local urlencode = lib.urlencode

    it("should escape reserved characters", function()
        local gen_delims = { ":", "/", "?", "#", "[", "]", "@" }
        local escaped_gen_delims = { "%3A", "%2F", "%3F", "%23", "%5B", "%5D", "%40" }
        for i = 1, #gen_delims do
            assert.are.equal(escaped_gen_delims[i], urlencode(gen_delims[i]))
        end

        local sub_delims = { "!", "$", "&", "'", "(", ")", "*", "+", ",", ";", "=" }
        local escaped_sub_delims = { "%21", "%24", "%26", "%27", "%28", "%29", "%2A", "%2B", "%2C", "%3B", "%3D" }
        for i = 1, #sub_delims do
            assert.are.equal(escaped_sub_delims[i], urlencode(sub_delims[i]))
        end
    end)

    it("should not escape unreserved characters", function()
        for i = 48, 57 do
            local digit = string.char(i)
            assert.are.equal(digit, urlencode(digit))
        end

        for i = 65, 90 do
            local uppercase_alpha = string.char(i)
            assert.are.equal(uppercase_alpha, urlencode(uppercase_alpha))
        end

        for i = 97, 122 do
            local lowercase_alpha = string.char(i)
            assert.are.equal(lowercase_alpha, urlencode(lowercase_alpha))
        end

        local other_chars = { "-", ".", "_", "~" }
        for i = 1, #other_chars do
            assert.are.equal(other_chars[i], urlencode(other_chars[i]))
        end
    end)

    it("should escape space as a plus sign", function()
        assert.are.equal("+", urlencode(" "))
    end)

    it("should escape unicode characters byte by byte", function()
        local unicode_string = "árvíztűrő tükörfúrógép"
        local escaped_unicode_string = "%C3%A1rv%C3%ADzt%C5%B1r%C5%91+t%C3%BCk%C3%B6rf%C3%BAr%C3%B3g%C3%A9p"
        assert.are.equal(escaped_unicode_string, urlencode(unicode_string))
    end)

    it("should return nil on nil input", function()
        assert.are.equal(nil, urlencode())
    end)

end)

describe("urldecode", function()
    local urldecode = lib.urldecode

    it("should unescape plus sign as a space", function()
        assert.are.equal(" ", urldecode("+"))
    end)

    it("should unescape escaped characters", function()
        local escaped_reserved_chars = "%3A%2F%3F%23%5B%5D%40%21%24%26%27%28%29%2A%2B%2C%3B%3D"
        local reserved_chars = ":/?#[]@!$&'()*+,;="
        assert.are.equal(reserved_chars, urldecode(escaped_reserved_chars))
    end)

    it("should unescape multibyte unicode characters", function()
        local escaped_unicode_string = "%C3%A1rv%C3%ADzt%C5%B1r%C5%91+t%C3%BCk%C3%B6rf%C3%BAr%C3%B3g%C3%A9p"
        local unicode_string = "árvíztűrő tükörfúrógép"
        assert.are.equal(unicode_string, urldecode(escaped_unicode_string))
    end)

    it("should not escape other characters", function()
        local unreserved_chars = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
        assert.are.equal(unreserved_chars, urldecode(unreserved_chars))
    end)

    it("should return nil on nil input", function()
        assert.are.equal(nil, urldecode())
    end)

end)
