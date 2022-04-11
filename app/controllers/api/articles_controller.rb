module Api
  # Controller that handles CRUD operations for articles
  class ArticlesController < ApplicationController
    before_action :logged_in!
    before_action :check_user, only: :create

    def user_articles
      user = User.find_by(id: params[:id])

      if user.nil?
        render json: {
          errors: [
            'Golfer with this id was not found'
          ]
        }, status: :not_found
      else
        articles = user.articles.order(created_at: :desc)
        render json: {
          user: {
            id: user.id,
            name: user.name,
            articles: articles.map(&:serialize)
          }
        }.to_json
      end
    end

    def create
      article = current_user.articles.build(article_params)

      if article.save
        render json: {
          article: article.serialize
        }
      else
        render json: {
          errors: article.errors.messages
        }, status: :bad_request
      end
    end

    def show
      user = User.find_by(id: params[:id])

      if user.nil?
        render json: {
          errors: [
            'Golfer with this id was not found'
          ]
        }, status: :not_found
      else
        article = Article.find_by(id: params[:post_id], user_id: user.id)
        if article.nil?
          render json: {
            errors: [
              'There is no article with this id'
            ]
          }, status: :not_found
        else
          render json: {
            article: article.serialize
          }.to_json
        end
      end
    end

    private

    def article_params
      params.require(:article).permit(:title, :description)
    end

    def check_user
      @user = User.find(params[:id])

      return if current_user == @user

      render json: {
        errors: [
          'Cant post an article for another user'
        ]
      }, status: :unauthorized
    end
  end
end
