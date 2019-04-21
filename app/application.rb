require 'hyalite'
#require 'menilite'

class AppView
  include Hyalite::Component

  def play
    %x(
      var context = new AudioContext();
      var buffer = null;
      var source = context.createBufferSource();

      var request = new XMLHttpRequest();
      request.open('GET', 'assets/sounds/sample.mp3', true);
      request.responseType = 'arraybuffer';
      request.send();

      request.onload = function() {
        var res = request.response;
        context.decodeAudioData(res, function(buf) {
          source.buffer = buf;
        });
      };
      source.connect(context.destination);
      source.start(0);
    )
  end

  def render
    div(nil,
      h2(nil, 'Welcome Web Audio'),
        button({onClick: self.method(:play)}, 'Play')
    )
  end
end
Hyalite.render(Hyalite.create_element(AppView), $document['.content'])
