require "test_helper"
require "propshaft/resolver/static"

class Propshaft::Resolver::StaticTest < ActiveSupport::TestCase
  setup do
    @resolver = Propshaft::Resolver::Static.new(
      manifest_path: Pathname.new("#{__dir__}/../../fixtures/output/.manifest.json"),
      prefix: "/assets"
    )
  end

  test "resolving present asset returns uri path" do
    assert_equal \
      "/assets/one-f2e1ec14d6856e1958083094170ca6119c529a73.txt",
      @resolver.resolve("one.txt")
  end

  test "resolving missing asset raises a custom error" do
    assert_raise Propshaft::MissingAssetError do
      assert_nil @resolver.resolve("nowhere.txt")
    end
  end

  test "integrity of an existing asset returns value" do
    assert_equal "sha384-LdS8l2QTAF8bD8WPb8QSQv0skTWHhmcnS2XU5LBkVQneGzqIqnDRskQtJvi7ADMe",
                 @resolver.integrity("one.txt")
  end

  test "integrity of missing asset raises a custom error" do
    assert_raise Propshaft::MissingAssetError do
      assert_nil @resolver.integrity("nowhere.txt")
    end
  end
end
