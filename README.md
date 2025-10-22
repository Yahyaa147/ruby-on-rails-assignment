# Odev API – Ödev Raporu

## Proje Özeti
- **Hedef**: Kullanıcıyı selamlayan ve en az üç ilişkili modeli gösteren bir Rails API’si sunmak (ek puan için beş model uygulandı).
- **Modeller**: `Teacher`, `Course`, `Student`, `Enrollment`, `Assignment`.
- **Selamlama Uç Noktası**: `GET /api/v1/hello` (kök rota olarak da ayarlandı) zorunlu selamlamayı döner ve model ilişkilerini vurgular.

## Teknoloji Yığını
- Ruby 3.2.x
- Rails 7.1.x (yalnızca API)
- SQLite (geliştirme/test)
- Çapraz kaynak erişimi için etkinleştirilmiş Rack CORS

## Başlarken
1. `bundle install`
2. `bin/rails db:create db:migrate db:seed`
3. `bin/rails server`
4. `http://localhost:3000/api/v1/hello` adresini ziyaret edin

## Alan Modeli
- **Teacher** birçok `courses` kaydına sahiptir.
- **Course** bir `teacher`a aittir, birçok `assignments` kaydına sahiptir ve `enrollments` üzerinden `students` ile bağlanır.
- **Student** `enrollments` aracılığıyla birçok `courses` kaydına sahiptir.
- **Enrollment** `students` ve `courses` kayıtlarını birleştirir; benzersizlik kısıtı tekrar kayıt oluşturmayı engeller.
- **Assignment** bir `course`a aittir ve teslim tarihleri ile yönergeleri taşır.

## Başlıca API Uç Noktaları
- `GET /api/v1/hello`
- `resources :teachers`
- `resources :students` (iç içe `enrollments#index`)
- `resources :courses` (iç içe `assignments#index`, `enrollments#index`)
- `resources :assignments`
- `resources :enrollments` (`index`, `create`, `destroy` ve isteğe bağlı `course_id`/`student_id` filtreleri)

Hazır veriler tohumlar ile sağlanır; ayrıntılar için `db/seeds.rb` dosyasına bakın.

## Testler
- Modelleri ve istekleri kapsamak için `bin/rails test` komutunu çalıştırın.
- Testler doğrulamaları, ilişkileri ve selamlama uç noktasını doğrular.

## Gereksinim Karşılama
- Beş ilişkili model içeren API-odaklı bir Rails uygulaması sunar.
- Ödev yönergesinde istenen selamlama uç noktasını sağlar.
- Model ilişkilerini gösteren tohum verileriyle gelir.
- Temel modeller ve uç noktalar için otomatik testler sunar.
- Bu README üzerinden çalışmayı belgelendirir ve herkese açık depo bağlantısını içerir.

## GitHub
- Depo URL’si: https://github.com/Yahyaa147/ruby-on-rails-assignment
