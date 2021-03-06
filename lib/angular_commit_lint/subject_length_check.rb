require 'angular_commit_lint/subject_pattern_check'

module Danger
  class DangerAngularCommitLint < Plugin
    class SubjectLengthCheck < CommitCheck # :nodoc:
      def message
        'Please limit commit subject line to 50 characters.'.freeze
      end
      GIT_GENERATED_SUBJECT = /^Merge branch \'.+\' into\ /.freeze
      GITHUB_GENERATED_SUBJECT = /^Merge pull request #\d+ from\ /.freeze

      attr_reader :subject

      def self.type
        :subject_length
      end

      def initialize(message, _config = {})
        @subject = extract_subject(message)
      end

      def fail?
        subject.length > 50 && !merge_commit?
      end

      def merge_commit?
        subject =~ /#{GIT_GENERATED_SUBJECT}|#{GITHUB_GENERATED_SUBJECT}/
      end
    end
  end
end
