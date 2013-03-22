require 'guard/guard'

module ::Guard
  class ReloadMetaWordpress < ::Guard::Guard
    def run_on_changes(paths)
      ::Guard::Dsl.reevaluate_guardfile
    end
  end
end