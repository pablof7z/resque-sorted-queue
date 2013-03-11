Gem::Specification.new do |s|
  s.name     = "resque-sorted-queue"
  s.version  = "0.1"
  s.date     = Time.now.strftime('%Y-%m-%d')
  s.summary  = "A Resque plugin that prioritizes jobs based on the number of times they were requested"
  s.homepage = "http://github.com/heelhook/resque-sorted-queue"
  s.email    = "heelhook@littleq.net"
  s.authors  = [ "Pablo Fernandez" ]
  s.has_rdoc = false

  s.files    = %w( README.md Rakefile LICENSE )
  s.files   += Dir.glob("lib/**/*")
  s.files   += Dir.glob("test/**/*")

  s.add_dependency "resque"
  s.add_development_dependency "rake"
  s.add_development_dependency "rspec", "~> 2.12.0"
  s.add_development_dependency "test-unit" # avoids a weird issue: http://bit.ly/PATaLp

  s.description       = <<desc
A Resque plugin that prioritizes jobs based on the number of times they were requested.

For example:

    class ExampleJob
      extend Resque::Jobs::Queue::Sorted

      def self.perform(repo_id)
        heavy_lifting
      end
    end

    Resque.enqueue(ExampleJob, "unpopular job")
    Resque.enqueue(ExampleJob, "semipopular job")
    Resque.enqueue(ExampleJob, "semipopular job")
    Resque.enqueue(ExampleJob, "popular job")
    Resque.enqueue(ExampleJob, "popular job")
    Resque.enqueue(ExampleJob, "popular job")

    # rake resque:worker

    # "popular job"     processed
    # "semipopular job" processed
    # "unpopular job"   processed
desc
end