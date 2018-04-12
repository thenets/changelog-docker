import assert from "assert";
import parseTime from "../shared/parseTime";

describe("parseTime", function() {
  it("parses colon-style syntax", function() {
    assert.equal(5643, parseTime("1:34:03"));
    assert.equal(3843, parseTime("01:04:03"));
  });

  it("parses youtube-style syntax", function() {
    assert.equal(5643, parseTime("1h34m3s"));
    assert.equal(2079, parseTime("34m39s"));
    assert.equal(120, parseTime("2m"));
    assert.equal(3600, parseTime("1h"));
  });

  it("parses seconds-style syntax", function() {
    assert.equal(354, parseTime("354"));
    assert.equal(1, parseTime("1"));
    assert.equal(12345, parseTime("12345"));
  });

  it("returns 0 when parsing fails", function() {
    assert.equal(0, parseTime("notevenclose"));
  });

  it("returns null when given nothing", function() {
    assert.equal(null, parseTime());
  });
});
