require File.dirname(__FILE__) + '/test_helper.rb'

Depo.configure do
  root 'public'
end

class DijitConventionsTest < GeneratorTest
  def test_basics
    dijit=Depo::DijitConventions.new('app.my.Dijit')

    assert_equal('public/src/app/my', dijit.package_path)
    assert_equal('public/src/app/themes/basic/my', dijit.style_dir_path)
    assert_equal('public/src/app/tests/my', dijit.test_dir_path)

    assert_equal('public/src/app/my/Dijit.js', dijit.class_path)
    assert_equal('public/src/app/themes/basic/my/Dijit.css', dijit.style_path)
    assert_equal('public/src/app/tests/my/Dijit.js', dijit.test_code_path)
    assert_equal('public/src/app/tests/my/Dijit.html', dijit.test_page_path)

    assert_not_nil(dijit.to_hash)
  end
end
