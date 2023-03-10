# frozen_string_literal: true

# Copyright (c) 2022 Weihang Jian <https://tonytonyjan.net>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# An implementation of draft-faltstrom-base45-10, see
# https://datatracker.ietf.org/doc/draft-faltstrom-base45/
module Base45Lite
  class Error < ::StandardError; end
  class OverflowError < Error; end
  class InvalidCharacterError < Error; end
  class ForbiddenLengthError < Error; end

  MAX_UINT18 = 2**16 - 1
  SQUARED_45 = 45**2
  MAPPING = [
    *'0'..'9',
    *'A'..'Z',
    ' ', '$', '%', '*', '+', '-', '.', '/', ':'
  ].map!.with_index { |x, i| [i, x] }.to_h.freeze
  REVERSE_MAPPING = MAPPING.invert.freeze

  def self.encode(input)
    sequence = []
    input.unpack('n*').map! do |uint16|
      i, c = uint16.divmod(45)
      i, d = i.divmod(45)
      _, e = i.divmod(45)
      sequence.push(c, d, e)
    end
    if input.bytesize.odd?
      i, c = input.getbyte(-1).divmod(45)
      _, d = i.divmod(45)
      sequence.push(c, d)
    end
    sequence.map!{ |n| MAPPING[n] }.join
  end

  def self.decode(input)
    input
      .chars.map! { |c| REVERSE_MAPPING[c] || raise(InvalidCharacterError) }
      .each_slice(3).map do |slice|
        c, d, e = slice
        raise ForbiddenLengthError if d.nil?

        sum = c + d * 45
        sum += e * SQUARED_45 if e
        raise OverflowError if sum > MAX_UINT18

        sum
      end
      .pack((input.length % 3).zero? ? 'n*' : "n#{input.length / 3}C")
  end
end
