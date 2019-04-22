require 'hyalite'
#require 'menilite'

class AppView
  include Hyalite::Component

  def play
    context = Native(`new AudioContext()`)
    source = context.createBufferSource

    request = Native(`new XMLHttpRequest()`)
    request.open('GET', 'assets/sounds/sample.mp3', true)
    request.responseType = 'arraybuffer'
    request.send

    request.onload = Proc.new do
      res = request.response
      context.decodeAudioData(res) do |buf|
        source.buffer = buf
      end
    end

    source.connect(context.destination)
    source.start(0)
  end

  def render
    div(nil,
      h2(nil, 'Welcome Web Audio'),
        button({onClick: self.method(:play)}, 'Play')
    )
  end
end
Hyalite.render(Hyalite.create_element(AppView), $document['.content'])
