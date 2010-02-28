require File.dirname(__FILE__) + '/test_helper.rb'

Depo.configure do
  root 'public'
end

class DepoConfigureTest < GeneratorTest 
  def test_roots
    assert_equal('public', Depo.config.root)
    assert_equal('public/src', Depo.config.src_path)
    assert_equal('public/builds', Depo.config.builds_path)
  end
end
