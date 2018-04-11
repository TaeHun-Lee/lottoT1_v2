class Lotto < ApplicationRecord
    serialize :lttoarr, Array
    serialize :lttorandarr, Array
    serialize :lttogetarr, Array
end
