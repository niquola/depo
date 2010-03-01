Depo.configure do
  root 'public'
  author 'yorname'
  generators do
    head_of_test_page <<-HTML
     <!-- some code to title of test page -->
    HTML
  end
end
