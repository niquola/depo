require File.dirname(__FILE__) + '/test_helper.rb'

class DijitConventionsTest < GeneratorTest
  def test_basics
    dijit=Depo::DijitConventions.new('app.my.Dijit')

    assert_equal('public/ria/src/app/my', dijit.package_path)
    assert_equal('public/ria/src/app/themes/tundra/my', dijit.style_dir_path)
    assert_equal('public/ria/src/app/tests/my', dijit.test_dir_path)

    assert_equal('public/ria/src/app/my/Dijit.js', dijit.class_path)
    assert_equal('public/ria/src/app/themes/tundra/my/Dijit.css', dijit.style_path)
    assert_equal('public/ria/src/app/tests/my/Dijit.js', dijit.test_code_path)
    assert_equal('public/ria/src/app/tests/my/Dijit.html', dijit.test_page_path)

    assert_not_nil(dijit.to_hash)
  end

  def test_conventions
    dijit=Depo::DijitConventions.new('app.Dijit')
    assert_equal('public/ria/src/app', dijit.package_path)
  end
end
