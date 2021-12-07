# == Schema Information
#
# Table name: shortened_urls
#
#  id           :bigint           not null, primary key
#  long_url     :string           not null
#  short_url    :string           not null
#  submitter_id :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class ShortenedUrl < ApplicationRecord
    validates :long_url, :short_url, :submitter, presence: true
    validates :short_url, uniqueness: true
    validate  :no_spamming, :nonpremium_max

    belongs_to :submitter,
    class_name: :User,
    foreign_key: :submitter_id,
    primary_key: :id

    has_many :visits,
    class_name: :Visit,
    foreign_key: :shortened_url_id,
    primary_key: :id

    has_many :visitors,
    -> {distinct},
    through: :visits,
    source: :visitor

    has_many :taggings,
    class_name: :Tagging,
    foreign_key: :shortened_url_id,
    primary_key: :id

    has_many :tag_topics,
    through: :taggings,
    source: :tag_topic


  def num_clicks
    visits.count
  end

  def num_uniques
    visits.select('user_id').distinct.count
  end

  def num_recent_uniques
    visits.select('user_id')
          .where('created_at > ?', 10.minutes.ago)
          .distinct
          .count
  end

  def self.user_and_shorturl(user, long_url)
    ShortenedUrl.create!(
      submitter_id: user.id,
      long_url: long_url,
      short_url: ShortenedUrl.random_code
    )
  end

  def self.random_code
    random_code = SecureRandom.urlsafe_base64(16)
    return random_code unless ShortenedUrl.exists?(random_code)

  end


  def self.prune(n)
    ShortenedUrl
      .joins(:submitter)
      .joins('LEFT JOIN visits ON visits.shortened_url_id = shortened_urls.id')
      .where("(shortened_urls.id IN (
        SELECT shortened_urls.id
        FROM shortened_urls
        JOIN visits
        ON visits.shortened_url_id = shortened_urls.id
        GROUP BY shortened_urls.id
        HAVING MAX(visits.created_at) < \'#{n.minute.ago}\'
      ) OR (
        visits.id IS NULL and shortened_urls.created_at < \'#{n.minutes.ago}\'
      )) AND users.premium = \'f\'")
      .destroy_all

    # The sql for the query would be:
    #
    # SELECT shortened_urls.*
    # FROM shortened_urls
    # JOIN users ON users.id = shortened_urls.submitter_id
    # LEFT JOIN visits ON visits.shortened_url_id = shortened_urls.id
    # WHERE (shortened_urls.id IN (
    #   SELECT shortened_urls.id
    #   FROM shortened_urls
    #   JOIN visits ON visits.shortened_url_id = shortened_urls.id
    #   GROUP BY shortened_urls.id
    #   HAVING MAX(visits.created_at) < "#{n.minute.ago}"
    # ) OR (
    #   visits.id IS NULL and shortened_urls.created_at < '#{n.minutes.ago}'
    # )) AND users.premium = 'f'
  end

  # def self.prune(n)
  #   time = n.minute.ago
  #   ShortenedUrl.where('created_at < ?', time).delete_all

  # end

  private
  def no_spamming
    last_min = ShortenedUrl
      .where('created_at > ?', 1.minute.ago)
      .where(submitter_id: submitter_id)
      .length 
      errors[:maximum] << "of 5 urls per min " if last_min >= 5 
  end

  def nonpremium_max
    return if User.find(self.submitter_id).premium 

    limited_urls = ShortenedUrl
      .where(submitter_id: submitter_id)
      .length

    errors[:Only] << "premium members can create more than 5 urls" if limited_urls >= 5
      
  end


end

# u1 = User.create!(email: 'jefferson@cats.com', premium: true)
# u2 = User.create!(email: 'muenster@cats.com')

# su1 = ShortenedUrl.user_and_shorturl(u1, 'www.boxes.com')
# su2 = ShortenedUrl.user_and_shorturl(u2, 'www.meowmix.com')
# su3 = ShortenedUrl.user_and_shorturl(u2, 'www.smallrodents.com')

# v1 = Visit.create!(user_id: u1.id, shortened_url_id: su1.id)
# v2 = Visit.create!(user_id: u1.id, shortened_url_id: su2.id)



# su2 = ShortenedUrl.user_and_shorturl(u2, 'www.meowmix.com')
# v3 = Visit.create!(user_id: u2.id, shortened_url_id: su2.id)
# v4 = Visit.create!(user_id: u1.id, shortened_url_id: su2.id)
