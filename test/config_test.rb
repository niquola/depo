require File.dirname(__FILE__) + '/test_helper.rb'

Depo.configure do
  root 'public'
  author 'niquola@gmail.com'
  generators do
    head_of_test_page <<-HTML
    <link rel="stylesheet" href="#{Depo.config.src_path}/common.css" type="text/css" />
    HTML
  end
end

class DepoConfigureTest < GeneratorTest 
  def test_roots
    config=Depo.config
    assert_equal('public', config.root)
    assert_equal('public/src', config.src_path)
    assert_equal('public/builds', config.builds_path)
    assert_equal('niquola@gmail.com', config.author)
    assert_match(/common.css/, config.generators.head_of_test_page )
  end
end
