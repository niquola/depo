require File.dirname(__FILE__) + '/test_helper.rb'
Depo.configure do
  root 'public'
end

PU = Depo::PathUtils
class PathUtilsTest < GeneratorTest 
  def test_basics
    dijit_full_name = 'app.my.Dijit'
    assert_equal('public/src/app/my', PU.package_path(dijit_full_name))
    assert_equal('public/src/app/themes/basic/my', PU.style_dir_path(dijit_full_name))
    assert_equal('public/src/app/tests/my', PU.test_dir_path(dijit_full_name))

    assert_equal('public/src/app/my/Dijit.js', PU.class_path(dijit_full_name))
    assert_equal('public/src/app/themes/basic/my/Dijit.css', PU.style_path(dijit_full_name))
    assert_equal('public/src/app/tests/my/Dijit.js', PU.test_code_path(dijit_full_name))
    assert_equal('public/src/app/tests/my/Dijit.html', PU.test_page_path(dijit_full_name))
  end
end
