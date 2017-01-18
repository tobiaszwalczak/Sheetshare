Template.chat.onRendered(() => {
  Tracker.autorun(function() {
    Meteor.subscribe("messages", Meteor.user().group.current);
    Meteor.subscribe("images", Meteor.user().group.current);
  });
  $("section.chat textarea").autosize();
  Meteor.setTimeout(() => {
    $("section.chat").animate({scrollTop: $("section.chat")[0].scrollHeight}, 500);
  }, 2000);
  UserStatus.startMonitor({threshold: 30000, interval: 1000, idleOnBlur: true});
  UserStatus.events.on("connectionLogout", () => { Meteor.call("updateIsTyping", false) });
  Meteor.call("updateIsTyping", false);
});

Template.chat.helpers({
  onlineStatusIndicator(creator) {
    if (creator.status.online) {
      if (creator.status.idle) return "idle";
      else return "online";
    } else {
      return "offline";
    }
  },
  onlineStatusName(creator) {
    if (creator.status.online) {
      if (creator.status.idle) return "Abwesend";
      else return "Online";
    } else {
      return "Offline";
    }
  },
  users() {
    return Users.find();
  },
  messages() {
    return Messages.find({}, {sort: {createdAt: 1}});
  },
  messagesExist() {
    if (Messages.findOne()) return true;
  },
  emojis() {
    return Emojis;
  }
});


Template.chat.events({
  "keypress section.chat #chat-textarea"(event) {
    if (event.which == 13) {
      const text = $("section.chat #chat-textarea").val();
      if (/\S/.test(text)) Meteor.call("createMessage", text, "text");
      $("section.chat").animate({scrollTop: $("section.chat")[0].scrollHeight}, 100)
      $("section.chat #chat-textarea").val("");
      $("section.chat #chat-textarea").trigger("autosize.resize");
      return false;
    }
  },
  "keyup section.chat #chat-textarea"() {
    const value = $("section.chat #chat-textarea").val();
    if (/\S/.test(value) && !Meteor.user().isTyping) Meteor.call("updateIsTyping", true);
    else if (!/\S/.test(value) && Meteor.user().isTyping) Meteor.call("updateIsTyping", false);
  },
  "click section.chat .emojis-button"() {
    $("section.chat .more-button.close").click();
    if (!$("section.chat .emojis-button").hasClass("close")) {
      $("section.chat .emojis-widget").addClass("showing");
      $("section.chat .emojis-button").attr({"data-tooltip": "Schließen"});
      Meteor.setTimeout(() => {
        $("section.chat .emojis-button").html("<i class='mdi mdi-close'>");
      }, 300);
    } else {
      $("section.chat .emojis-widget").removeClass("showing");
      $("section.chat .emojis-button").attr({"data-tooltip": "Emojis"});
      Meteor.setTimeout(() => {
        $("section.chat .emojis-button").html("<i class='mdi mdi-emoticon'>");
      }, 300);
    }
    $("section.chat .emojis-button").toggleClass("close");
  },
  "click section.chat .more-button"() {
    $("section.chat .emojis-button.close").click();

    if (!$("section.chat .more-button").hasClass("close")) {
      $("section.chat .more-widget").addClass("showing");
      $("section.chat .more-button").attr({"data-tooltip": "Schließen"});
      Meteor.setTimeout(() => {
        $("section.chat .more-button").html("<i class='mdi mdi-close'>");
      }, 300);
    } else {
      $("section.chat .more-widget").removeClass("showing");
      $("section.chat .more-button").attr({"data-tooltip": "Mehr"});
      Meteor.setTimeout(() => {
        $("section.chat .more-button").html("<i class='mdi mdi-dots-horizontal'>");
      }, 300);
      $("section.chat .latex-widget").removeClass("showing");
      Meteor.setTimeout(() => {
        $("section.chat .latex-widget #latex-textarea").val("");
        $("section.chat .latex-widget .latex-output").text("");
      }, 600);
    }
    $("section.chat .more-button").toggleClass("close");
  },
  "click section.chat .latex-button"() {
    $("section.chat .more-widget").removeClass("showing");
    $("section.chat .latex-widget").addClass("showing");
    Meteor.setTimeout(() => {
      $("section.chat .latex-widget #latex-textarea").focus();
    }, 600);
  },
  "click section.chat .image-button"() {
    $("section.chat .image-upload").click();
  },
  "change section.chat .image-upload"(event) {
    FS.Utility.eachFile(event, (file) => {
      const newFile = new FS.File(file);
      newFile.groupId = Meteor.user().group.current;
      Images.insert(newFile, (err, fileObj) => {
        $("section.chat .widget-button.close").click();
        Meteor.call("createMessage", "", "image", fileObj._id);
      });
    });
  },
  "focus section.chat #chat-textarea"() {
    $("section.chat .widget-button.close").click();
  },
  "click section.chat .emojis-widget .emoji-tag"(event) {
    const tag = ":" + $(event.currentTarget).attr("title") + ":";
    $("section.chat .emojis-button.close").click();
    insertAtCursor("chat-textarea", tag);
    $("section.chat #chat-textarea").focus();
    $("section.chat #chat-textarea").trigger("autosize.resize");
  },
  "keyup section.chat .latex-widget #latex-textarea"(event) {
    const input = $(event.target).val();
    $("section.chat .latex-widget .latex-output").text(input);
    $(".latex-output").latex();
    if (event.which == 13) {
      const text = $("section.chat .latex-widget #latex-textarea").val();
      if (/\S/.test(text)) {
        Meteor.call("createMessage", text, "latex");
        $("section.chat .more-button.close").click();
      }
      return false;
    } else if (event.which == 27) {
      $("section.chat #chat-textarea").focus();
      return false;
    }
  }
});

const insertAtCursor = (id, value) => {
  const field = document.getElementById(id);
  if (document.selection) {
    field.focus();
    const sel = document.selection.createRange();
    sel.text = value;
  } else if (field.selectionStart || field.selectionStart == "0") {
    const startPos = field.selectionStart;
    const endPos = field.selectionEnd;
    field.value = field.value.substring(0, startPos) + value + field.value.substring(endPos, field.value.length);
    field.selectionStart = field.selectionEnd = startPos + value.length;
  } else {
    field.value += value;
  }
};
