require "test_helper"
require "tmpdir"

class Slim::Rails::AnnotationExtractorTest < ActiveSupport::TestCase
  def create_temp_file(content)
    file = Tempfile.new(["test", ".slim"])
    file.write(content)
    file.close
    file
  end

  test "extracts TODO annotation from slim file" do
    file = create_temp_file("/ TODO: Fix this later\nh1 Hello")
    extractor = Slim::Rails::AnnotationExtractor.new(/\s*\/\s*(TODO):?\s*(.*)$/)

    annotations = extractor.annotations(file.path)

    assert_equal 1, annotations.size
    assert_equal 1, annotations.first.line
    assert_equal "TODO", annotations.first.tag
    assert_equal "Fix this later", annotations.first.text
  ensure
    file.unlink
  end

  test "extracts multiple annotations from slim file" do
    content = <<~SLIM
      / TODO: First task
      h1 Title
      / FIXME: Something broken
      p Content
    SLIM
    file = create_temp_file(content)
    extractor = Slim::Rails::AnnotationExtractor.new(/\s*\/\s*(TODO|FIXME):?\s*(.*)$/)

    annotations = extractor.annotations(file.path)

    assert_equal 2, annotations.size
    assert_equal 1, annotations.first.line
    assert_equal "TODO", annotations.first.tag
    assert_equal 3, annotations.last.line
    assert_equal "FIXME", annotations.last.tag
  ensure
    file.unlink
  end

  test "returns empty array when no annotations found" do
    file = create_temp_file("h1 Hello\np World")
    extractor = Slim::Rails::AnnotationExtractor.new(/\s*\/\s*(TODO):?\s*(.*)$/)

    annotations = extractor.annotations(file.path)

    assert_equal [], annotations
  ensure
    file.unlink
  end

  test "handles Japanese characters without encoding error" do
    content = <<~SLIM
      / TODO: 日本語のタスク
      h1 こんにちは
      p 世界
    SLIM
    file = create_temp_file(content)
    extractor = Slim::Rails::AnnotationExtractor.new(/\s*\/\s*(TODO):?\s*(.*)$/)

    annotations = extractor.annotations(file.path)

    assert_equal 1, annotations.size
    assert_equal "TODO", annotations.first.tag
    assert_equal "日本語のタスク", annotations.first.text
  ensure
    file.unlink
  end

  test "handles mixed encoding content gracefully" do
    # Create file with potentially problematic encoding
    file = Tempfile.new(["test", ".slim"], encoding: "ASCII-8BIT")
    file.write("/ TODO: Test task\nh1 Hello".force_encoding("ASCII-8BIT"))
    file.close

    extractor = Slim::Rails::AnnotationExtractor.new(/\s*\/\s*(TODO):?\s*(.*)$/)

    # Should not raise Encoding::UndefinedConversionError
    annotations = extractor.annotations(file.path)

    assert_equal 1, annotations.size
  ensure
    file.unlink
  end
end
