class EmailDomain < ActiveModel::Validator
    def validate(record)
        email_domains = File.open(Rails.root.join("app", "assets", "texts","email_providers.txt")).readlines.map(&:chomp)
      unless email_domains.include? record.email
        record.errors.add :email, "Apenas email empresarial permitido"
      end
    end
  end