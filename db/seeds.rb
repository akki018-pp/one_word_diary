require 'faker'

users = 5.times.map do |i|
  User.find_or_create_by!(email: "user#{i + 1}@example.com") do |user|
    user.name = "user#{i + 1}"
    user.password = "password"
    user.password_confirmation = "password"
  end
end

time_slots = {
  morning: 8,
  afternoon: 14,
  evening: 20
}

users.each do |user|
  7.times do |i|
    day = i.days.ago.to_date

    time_slots.each do |slot, hour|
      created_time = Time.zone.local(day.year, day.month, day.day, hour)

      tweet_text = "#{Faker::Emotion.adjective}な気持ちです。#{Faker::JapaneseMedia::StudioGhibli.quote}"
      tweet_text = tweet_text.slice(0, 50)

      user.posts.find_or_create_by!(
        time_slot: slot,
        created_at: created_time.beginning_of_hour
      ) do |post|
        post.tweet = tweet_text
        post.updated_at = created_time
      end
    end
  end
end